import 'dart:convert';
import 'dart:developer';
import 'package:deen/core/models/ayah.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReflectionRepository {
  static const String _cacheKey = 'cached_reflection';
  static const String _cacheDateKey = 'cached_reflection_date';

  // Curated list of verse references about peace, patience, and spiritual strength
  static const List<String> verseReferences = [
    '2:153',
    '2:155',
    '2:156',
    '3:200',
    '16:127',
    '8:46',
    '11:115',
    '30:60',
    '31:17',
    '39:10',
    '25:75',
    '47:31',
    '70:5',
    '2:282',
    '28:59',
    '21:73',
    '11:118',
    '16:42',
    '17:7',
    '42:43',
    '22:35',
    '28:54',
    '28:80',
    '24:55',
    '9:87',
    '103:3',
    '13:24',
    '32:24',
  ];

  String _getTodayDateString() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  int _getVerseIndexForToday() {
    final now = DateTime.now();
    final epoch = DateTime(2025, 1, 1);
    final daysSinceEpoch = now.difference(epoch).inDays;

    // Cycle through verse references
    return daysSinceEpoch % verseReferences.length;
  }

  Future<Ayah> _fetchReflectionFromApi(String verseReference) async {
    try {
      final url = Uri.parse(
        'http://api.alquran.cloud/v1/ayah/$verseReference/editions/quran-uthmani,en.asad',
      );

      log('Fetching reflection for verse: $verseReference');
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
        throw Exception('Failed to fetch reflection: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching reflection: $e');
      rethrow;
    }
  }

  Future<void> _cacheReflection(String verseReference, String date) async {
    final prefs = await SharedPreferences.getInstance();
    final reflectionJson = jsonEncode({'verseReference': verseReference});

    await prefs.setString(_cacheKey, reflectionJson);
    await prefs.setString(_cacheDateKey, date);
  }

  Future<Ayah> getReflectionOfTheDay() async {
    final todayDate = _getTodayDateString();
    final prefs = await SharedPreferences.getInstance();
    final cachedDate = prefs.getString(_cacheDateKey);

    if (cachedDate == todayDate) {
      final cachedReflection = prefs.getString(_cacheKey);
      if (cachedReflection != null) {
        try {
          final json = jsonDecode(cachedReflection);
          final verseReference = json['verseReference'];
          return await _fetchReflectionFromApi(verseReference);
        } catch (e) {
          throw Exception('Failed to fetch reflection');
        }
      }
    }

    // Fetch new reflection for today
    final verseIndex = _getVerseIndexForToday();
    final verseReference = verseReferences[verseIndex];
    final reflection = await _fetchReflectionFromApi(verseReference);

    // Cache the reflection
    await _cacheReflection(verseReference, todayDate);

    return reflection;
  }
}
