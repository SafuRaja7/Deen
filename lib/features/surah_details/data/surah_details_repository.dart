import 'dart:convert';
import 'dart:io';
import 'package:deen/core/models/ayah.dart';
import 'package:deen/core/services/quran_data_service.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurahDetailsRepository {
  static const String _baseUrl = 'https://api.alquran.cloud/v1';
  final QuranDataService _dataService = QuranDataService();

  Future<SurahDetail> fetchSurahDetail(
    int number, {
    int offset = 0,
    int limit = 5,
  }) async {
    // Pull directly from the pre-loaded full Quran data service
    final surah = await _dataService.getSurah(number);
    if (surah == null) throw Exception('Surah $number not found in local data');

    // Return the specific slice requested by the Bloc's pagination logic
    final end = (offset + limit) > surah.ayahs.length
        ? surah.ayahs.length
        : (offset + limit);
    final slicedAyahs = surah.ayahs.sublist(offset, end);

    return SurahDetail(
      number: surah.number,
      name: surah.name,
      englishName: surah.englishName,
      englishNameTranslation: surah.englishNameTranslation,
      revelationType: surah.revelationType,
      numberOfAyahs: surah.numberOfAyahs,
      ayahs: slicedAyahs,
    );
  }

  Future<Map<String, dynamic>> fetchAyahAudio(int ayahNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'ayah_audio_info_$ayahNumber';

    final cachedInfo = prefs.getString(cacheKey);
    if (cachedInfo != null) {
      try {
        final info = json.decode(cachedInfo);
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

      String? localPath;
      try {
        localPath = await _downloadAudio(audioUrl, ayahNumber);
      } catch (e) {}

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
    } catch (e) {}
    return null;
  }

  Future<void> saveLastRead({
    required int surahNumber,
    required String surahName,
    required int ayahNumber,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_read_surah_number', surahNumber);
    await prefs.setString('last_read_surah_name', surahName);
    await prefs.setInt('last_read_ayah_number', ayahNumber);
  }

  Future<void> saveLastPlayed({
    required int surahNumber,
    required String surahName,
    required int ayahNumberInSurah,
    required int globalAyahNumber,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cached_surah_number', surahNumber);
    await prefs.setString('cached_surah_name', surahName);
    await prefs.setInt('cached_ayah_number', ayahNumberInSurah);
    await prefs.setInt('cached_global_ayah_number', globalAyahNumber);
  }

  Future<void> toggleBookmark(int surahNumber, int ayahNumberInSurah) async {
    return _dataService.toggleBookmark(surahNumber, ayahNumberInSurah);
  }
}
