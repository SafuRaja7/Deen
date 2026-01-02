import 'dart:convert';
import 'dart:io';
import 'package:deen/core/models/ayah.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurahDetailsRepository {
  static const String _baseUrl = 'https://api.alquran.cloud/v1';

  Future<SurahDetail> fetchSurahDetail(
    int number, {
    int offset = 0,
    int limit = 5,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'surah_detail_${number}_${offset}_$limit';

    // Try to get from cache first
    final cachedData = prefs.getString(cacheKey);
    if (cachedData != null) {
      try {
        final decoded = json.decode(cachedData);
        return SurahDetail.fromJson(decoded);
      } catch (e) {
        // Fallback
      }
    }

    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/surah/$number/editions/quran-uthmani,en.asad?offset=$offset&limit=$limit',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final surahData = data['data'];

        // Cache the result
        await prefs.setString(cacheKey, json.encode(surahData));

        return SurahDetail.fromJson(surahData);
      } else {
        throw Exception('Failed to load surah details');
      }
    } catch (e) {
      if (cachedData != null) {
        final decoded = json.decode(cachedData);
        return SurahDetail.fromJson(decoded);
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchAyahAudio(int ayahNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'ayah_audio_info_$ayahNumber';

    // Try cache for metadata
    final cachedInfo = prefs.getString(cacheKey);
    if (cachedInfo != null) {
      try {
        final info = json.decode(cachedInfo);
        // Check if local file exists
        if (info['localPath'] != null) {
          final file = File(info['localPath']);
          if (await file.exists()) {
            return info;
          }
        }
      } catch (_) {}
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/ayah/$ayahNumber/ar.alafasy'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final ayahData = data['data'];
      final audioUrl = ayahData['audio'];

      // Download audio for offline use
      String? localPath;
      try {
        localPath = await _downloadAudio(audioUrl, ayahNumber);
      } catch (e) {
        // Continue with remote URL if download fails
      }

      final info = {
        'audio': audioUrl,
        'audioSecondary': (ayahData['audioSecondary'] as List).isNotEmpty
            ? ayahData['audioSecondary'][0]
            : null,
        'numberInSurah': ayahData['numberInSurah'],
        'localPath': localPath,
      };

      await prefs.setString(cacheKey, json.encode(info));
      return info;
    } else {
      throw Exception('Failed to load ayah audio');
    }
  }

  Future<String?> _downloadAudio(String url, int ayahNumber) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final audioDir = Directory('${directory.path}/audio');
      if (!await audioDir.exists()) {
        await audioDir.create(recursive: true);
      }

      final filePath = '${audioDir.path}/ayah_$ayahNumber.mp3';
      final file = File(filePath);

      if (await file.exists()) {
        return filePath;
      }

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      }
    } catch (e) {
      // Log or handle error
    }
    return null;
  }
}
