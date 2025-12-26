import 'dart:convert';
import 'package:deen/core/models/ayah.dart';
import 'package:deen/core/utils/app_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReflectionRepository {
  static const String _cacheKey = 'cached_reflection';
  static const String _cacheDateKey = 'cached_reflection_date';

  String _getTodayDateString() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  int _getVerseIndexForToday() {
    final now = DateTime.now();
    final epoch = DateTime(2025, 1, 1);
    final daysSinceEpoch = now.difference(epoch).inDays;

    return daysSinceEpoch % AppUtils.verseReferences.length;
  }

  Future<Ayah> _fetchReflectionFromApi(String verseReference) async {
    try {
      final url = Uri.parse(
        'http://api.alquran.cloud/v1/ayah/$verseReference/editions/quran-uthmani,en.asad',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['data'] == null) {
          throw Exception('API returned null data');
        }

        return Ayah.fromJson(json['data']);
      } else {
        throw Exception('Failed to fetch reflection: ${response.statusCode}');
      }
    } catch (e) {
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

    final verseIndex = _getVerseIndexForToday();
    final verseReference = AppUtils.verseReferences[verseIndex];
    final reflection = await _fetchReflectionFromApi(verseReference);

    await _cacheReflection(verseReference, todayDate);

    return reflection;
  }
}
