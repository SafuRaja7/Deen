import 'dart:convert';
import 'package:deen/core/models/surah.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuranRepository {
  static const String _baseUrl = 'https://api.alquran.cloud/v1';
  static const String _kSurahCacheKey = 'quran_surah_list';

  Future<List<Surah>> fetchSurahs() async {
    final prefs = await SharedPreferences.getInstance();

    // Try to get from cache first
    final cachedData = prefs.getString(_kSurahCacheKey);
    if (cachedData != null) {
      try {
        final List decoded = json.decode(cachedData);
        return decoded.map((json) => Surah.fromJson(json)).toList();
      } catch (e) {
        // Fallback
      }
    }

    try {
      final response = await http.get(Uri.parse('$_baseUrl/surah'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> surahsJson = data['data'];

        // Cache the result
        await prefs.setString(_kSurahCacheKey, json.encode(surahsJson));

        return surahsJson.map((json) => Surah.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load surahs');
      }
    } catch (e) {
      if (cachedData != null) {
        final List decoded = json.decode(cachedData);
        return decoded.map((json) => Surah.fromJson(json)).toList();
      }
      rethrow;
    }
  }
}
