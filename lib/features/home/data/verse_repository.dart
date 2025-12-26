import 'dart:convert';
import 'dart:developer';
import 'package:deen/core/models/ayah.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class VerseOfTheDayRepository {
  static const String _cacheKey = 'cached_verse';
  static const String _cacheDateKey = 'cached_verse_date';
  static const int totalVerses = 6236;
  int _getVerseNumberForToday() {
    final now = DateTime.now();
    final epoch = DateTime(2025, 1, 1);
    final daysSinceEpoch = now.difference(epoch).inDays;

    final verseNumber = (daysSinceEpoch % totalVerses) + 1;
    log(
      'Calculated verse number for today: $verseNumber (days since epoch: $daysSinceEpoch)',
    );
    return verseNumber;
  }

  String _getTodayDateString() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  Future<Ayah> _fetchVerseFromApi(int verseNumber) async {
    try {
      final url = Uri.parse(
        'http://api.alquran.cloud/v1/ayah/$verseNumber/editions/quran-uthmani,en.asad',
      );

      log('Fetching verse $verseNumber from API...');
      final response = await http.get(url);
      log('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log('Response body: ${json.toString()}');

        if (json['data'] == null) {
          throw Exception('API returned null data');
        }

        return Ayah.fromJson(json['data']);
      } else {
        log('API error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to fetch verse: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching verse: $e');
      rethrow;
    }
  }

  Future<void> _cacheVerse(Ayah ayah, String date) async {
    final prefs = await SharedPreferences.getInstance();
    final verseJson = jsonEncode({
      'number': ayah.number,
      'arabicText': ayah.arabicText,
      'englishTranslation': ayah.englishTranslation,
    });

    await prefs.setString(_cacheKey, verseJson);
    await prefs.setString(_cacheDateKey, date);
  }

  Future<Ayah> getVerseOfTheDay() async {
    final todayDate = _getTodayDateString();
    final prefs = await SharedPreferences.getInstance();
    final cachedDate = prefs.getString(_cacheDateKey);

    if (cachedDate == todayDate) {
      final cachedVerse = prefs.getString(_cacheKey);
      if (cachedVerse != null) {
        try {
          final json = jsonDecode(cachedVerse);
          final verseNumber = json['number'];
          return await _fetchVerseFromApi(verseNumber);
        } catch (e) {
          throw Exception('Failed to fetch verse');
        }
      }
    }

    final verseNumber = _getVerseNumberForToday();
    final verse = await _fetchVerseFromApi(verseNumber);

    await _cacheVerse(verse, todayDate);

    return verse;
  }
}
