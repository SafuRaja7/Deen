import 'dart:convert';
import 'package:deen/core/models/ayah.dart';
import 'package:deen/core/models/location_data.dart';
import 'package:deen/core/models/prayer_timings.dart';
import 'package:deen/core/utils/app_utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  static const String _kLocationHistoryKey = 'location_history';
  static const String _kLastLocationKey = 'last_location';
  static const String _kVerseCacheKey = 'cached_verse';
  static const String _kVerseCacheDateKey = 'cached_verse_date';
  static const String _kReflectionCacheKey = 'cached_reflection';
  static const String _kReflectionCacheDateKey = 'cached_reflection_date';
  static const int totalVerses = 6236;

  // --- Location & Prayer Timings ---

  Future<String> getCurrentAddress() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return await getCachedLocation();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return await getCachedLocation();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return await getCachedLocation();
    }

    try {
      final pos = await Geolocator.getCurrentPosition();
      final places = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      if (places.isNotEmpty) {
        final place = places.first;
        final address = "${place.locality}, ${place.country}";
        await _saveLastLocation(address);
        return address;
      }
    } catch (e) {
      return await getCachedLocation();
    }
    return await getCachedLocation();
  }

  Future<String> getCachedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kLastLocationKey) ?? "Bardiana, Pakistan";
  }

  Future<void> _saveLastLocation(String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLastLocationKey, address);
  }

  Future<PrayerTimings> fetchPrayerTimings(String address) async {
    final now = DateTime.now();
    final date =
        "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
    final url = Uri.parse(
      "https://api.aladhan.com/v1/timingsByAddress/$date?address=$address&method=8",
    );

    try {
      final res = await http.get(url).timeout(const Duration(seconds: 10));
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        final timings = PrayerTimings.fromJson(json['data']);

        await _addToHistory(address, timings);

        return timings;
      }
    } catch (_) {
      final history = await getLocationHistory();
      final entry = history.cast<dynamic>().firstWhere(
        (e) => e.location == address,
        orElse: () => null,
      );
      if (entry != null && entry.timings.isNotEmpty) {
        return entry.timings.last;
      }
    }

    throw Exception("Failed to fetch prayer timings and no cache available");
  }

  Future<void> _addToHistory(String address, PrayerTimings timings) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_kLocationHistoryKey);
    List<LocationData> history = [];

    if (historyJson != null) {
      final List<dynamic> decoded = jsonDecode(historyJson);
      history = decoded.map((e) => LocationData.fromJson(e)).toList();
    }

    int index = history.indexWhere((e) => e.location == address);
    if (index != -1) {
      bool exists = history[index].timings.any(
        (t) =>
            t.hijri.full == timings.hijri.full ||
            (t.timings['Fajr'] == timings.timings['Fajr'] &&
                t.timings['Isha'] == timings.timings['Isha']),
      );

      if (!exists) {
        history[index].timings.add(timings);
      }
    } else {
      history.add(LocationData(location: address, timings: [timings]));
    }

    await prefs.setString(
      _kLocationHistoryKey,
      jsonEncode(history.map((e) => e.toJson()).toList()),
    );
  }

  Future<List<LocationData>> getLocationHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString(_kLocationHistoryKey);
    if (historyJson == null) return [];

    final List<dynamic> decoded = jsonDecode(historyJson);
    return decoded.map((e) => LocationData.fromJson(e)).toList();
  }

  // --- Verse of the Day ---

  Future<Ayah> getVerseOfTheDay() async {
    final todayDate = _getTodayDateString();
    final prefs = await SharedPreferences.getInstance();
    final cachedDate = prefs.getString(_kVerseCacheDateKey);

    if (cachedDate == todayDate) {
      final cachedVerse = prefs.getString(_kVerseCacheKey);
      if (cachedVerse != null) {
        try {
          return Ayah.fromJson(jsonDecode(cachedVerse));
        } catch (e) {
          // Fallback
        }
      }
    }

    final verseNumber = _getVerseNumberForToday();
    final verse = await _fetchAyahFromApi(verseNumber.toString());

    await _cacheVerse(verse, todayDate);

    return verse;
  }

  Future<void> _cacheVerse(Ayah ayah, String date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kVerseCacheKey, jsonEncode(ayah.toJson()));
    await prefs.setString(_kVerseCacheDateKey, date);
  }

  int _getVerseNumberForToday() {
    final now = DateTime.now();
    final epoch = DateTime(2025, 1, 1);
    final daysSinceEpoch = now.difference(epoch).inDays;
    return (daysSinceEpoch % totalVerses) + 1;
  }

  // --- Reflection of Peace ---

  Future<Ayah> getReflectionOfTheDay() async {
    final todayDate = _getTodayDateString();
    final prefs = await SharedPreferences.getInstance();
    final cachedDate = prefs.getString(_kReflectionCacheDateKey);

    if (cachedDate == todayDate) {
      final cachedReflection = prefs.getString(_kReflectionCacheKey);
      if (cachedReflection != null) {
        try {
          return Ayah.fromJson(jsonDecode(cachedReflection));
        } catch (e) {
          // Fallback
        }
      }
    }

    final verseIndex = _getVerseIndexForToday();
    final verseReference = AppUtils.verseReferences[verseIndex];
    final reflection = await _fetchAyahFromApi(verseReference);

    await _cacheReflection(reflection, todayDate);

    return reflection;
  }

  Future<void> _cacheReflection(Ayah ayah, String date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kReflectionCacheKey, jsonEncode(ayah.toJson()));
    await prefs.setString(_kReflectionCacheDateKey, date);
  }

  int _getVerseIndexForToday() {
    final now = DateTime.now();
    final epoch = DateTime(2025, 1, 1);
    final daysSinceEpoch = now.difference(epoch).inDays;

    return daysSinceEpoch % AppUtils.verseReferences.length;
  }

  // --- Common Helpers ---

  Future<Ayah> _fetchAyahFromApi(String identifier) async {
    final url = Uri.parse(
      'http://api.alquran.cloud/v1/ayah/$identifier/editions/quran-uthmani,en.asad',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['data'] == null) {
        throw Exception('API returned null data');
      }
      return Ayah.fromJson(json['data']);
    } else {
      throw Exception('Failed to fetch ayah: ${response.statusCode}');
    }
  }

  String _getTodayDateString() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  Future<void> preFetchAll() async {
    try {
      final address = await getCurrentAddress();
      await fetchPrayerTimings(address);
      await getVerseOfTheDay();
      await getReflectionOfTheDay();
    } catch (e) {
      // Silently fail pre-fetch
    }
  }
}
