import 'dart:convert';
import 'dart:io';
import 'package:deen/core/models/ayah.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranDataService {
  static final QuranDataService _instance = QuranDataService._internal();
  factory QuranDataService() => _instance;
  QuranDataService._internal();

  static const String _kQuranFileName = 'full_quran_data.json';
  static const String _kIsDownloadedKey = 'is_quran_downloaded';

  List<SurahDetail>? _cachedQuran;

  Future<bool> isDataDownloaded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kIsDownloadedKey) ?? false;
  }

  Future<void> initializeData() async {
    if (_cachedQuran != null) return;
    if (await isDataDownloaded()) {
      await _loadFromLocal();
    } else {
      await downloadAndCacheQuran();
    }
  }

  Future<void> downloadAndCacheQuran() async {
    final url = Uri.parse(
      'https://api.alquran.cloud/v1/quran/editions/quran-uthmani,en.asad',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final data = decoded['data'];

        List? editions;
        if (data is List) {
          editions = data;
        } else if (data is Map && data.containsKey('editions')) {
          editions = data['editions'];
        }

        if (editions != null && editions.length >= 2) {
          await _processAndCache(editions[0]['surahs'], editions[1]['surahs']);
          return;
        }
      }
    } catch (e) {
      // Fallback
    }

    try {
      final results = await Future.wait([
        http.get(Uri.parse('https://api.alquran.cloud/v1/quran/quran-uthmani')),
        http.get(Uri.parse('https://api.alquran.cloud/v1/quran/en.asad')),
      ]);

      if (results[0].statusCode == 200 && results[1].statusCode == 200) {
        final arabicSurahs =
            json.decode(results[0].body)['data']['surahs'] as List;
        final englishSurahs =
            json.decode(results[1].body)['data']['surahs'] as List;
        await _processAndCache(arabicSurahs, englishSurahs);
      } else {
        throw Exception(
          'Failed to download Quran data from both primary and fallback sources',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _processAndCache(List arabicSurahs, List englishSurahs) async {
    List<SurahDetail> mergedQuran = [];

    for (int i = 0; i < arabicSurahs.length; i++) {
      final aSurah = arabicSurahs[i];
      final eSurah = (i < englishSurahs.length) ? englishSurahs[i] : null;

      final List<AyahDetail> ayahs = [];
      final List aAyahs = aSurah['ayahs'] ?? [];
      final List eAyahs = (eSurah != null && eSurah.containsKey('ayahs'))
          ? eSurah['ayahs']
          : [];

      for (int j = 0; j < aAyahs.length; j++) {
        String translation = "Translation not available";
        if (j < eAyahs.length) {
          translation = eAyahs[j]['text'] ?? translation;
        }

        ayahs.add(
          AyahDetail(
            number: aAyahs[j]['number'] ?? 0,
            text: aAyahs[j]['text'] ?? "",
            translation: translation,
            numberInSurah: aAyahs[j]['numberInSurah'] ?? 0,
            juz: aAyahs[j]['juz'] ?? 0,
            page: aAyahs[j]['page'] ?? 0,
            surahName: aSurah['englishName'] ?? "",
            surahNumber: aSurah['number'] ?? 0,
          ),
        );
      }

      mergedQuran.add(
        SurahDetail(
          number: aSurah['number'] ?? 0,
          name: aSurah['name'] ?? "",
          englishName: aSurah['englishName'] ?? "",
          englishNameTranslation: aSurah['englishNameTranslation'] ?? "",
          revelationType: aSurah['revelationType'] ?? "",
          numberOfAyahs: aSurah['numberOfAyahs'] ?? ayahs.length,
          ayahs: ayahs,
        ),
      );
    }

    await _saveToLocal(mergedQuran);
    _cachedQuran = mergedQuran;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kIsDownloadedKey, true);
  }

  Future<void> _saveToLocal(List<SurahDetail> data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_kQuranFileName');
    final jsonString = json.encode(data.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  Future<void> _loadFromLocal() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_kQuranFileName');
    if (await file.exists()) {
      final jsonString = await file.readAsString();
      final List decoded = json.decode(jsonString);
      _cachedQuran = decoded.map((e) => SurahDetail.fromJson(e)).toList();
    }
  }

  Future<List<SurahDetail>> getFullQuran() async {
    await initializeData();
    return _cachedQuran ?? [];
  }

  Future<SurahDetail?> getSurah(int number) async {
    await initializeData();
    return _cachedQuran?.firstWhere((s) => s.number == number);
  }

  Future<List<AyahDetail>> getJuzAyahs(int juzNumber) async {
    await initializeData();
    List<AyahDetail> juzAyahs = [];
    if (_cachedQuran != null) {
      for (var surah in _cachedQuran!) {
        for (var ayah in surah.ayahs) {
          if (ayah.juz == juzNumber) {
            juzAyahs.add(ayah);
          }
        }
      }
    }
    return juzAyahs;
  }

  Future<List<AyahDetail>> getBookmarkedAyahs() async {
    await initializeData();
    List<AyahDetail> bookmarkedAyahs = [];
    if (_cachedQuran != null) {
      for (var surah in _cachedQuran!) {
        for (var ayah in surah.ayahs) {
          if (ayah.isBookmarked) {
            bookmarkedAyahs.add(ayah);
          }
        }
      }
    }
    return bookmarkedAyahs;
  }

  Future<void> toggleBookmark(int surahNumber, int ayahNumberInSurah) async {
    await initializeData();
    if (_cachedQuran == null) return;

    final surahIndex = _cachedQuran!.indexWhere((s) => s.number == surahNumber);
    if (surahIndex == -1) return;

    final ayahIndex = _cachedQuran![surahIndex].ayahs.indexWhere(
      (a) => a.numberInSurah == ayahNumberInSurah,
    );
    if (ayahIndex == -1) return;

    final currentAyah = _cachedQuran![surahIndex].ayahs[ayahIndex];
    final updatedAyah = currentAyah.copyWith(
      isBookmarked: !currentAyah.isBookmarked,
    );

    _cachedQuran![surahIndex].ayahs[ayahIndex] = updatedAyah;

    await _saveToLocal(_cachedQuran!);
  }
}
