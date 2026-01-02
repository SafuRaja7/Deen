import 'package:deen/core/models/ayah.dart';
import 'package:deen/core/services/quran_data_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParaRepository {
  final QuranDataService _dataService = QuranDataService();

  Future<List<AyahDetail>> fetchPara(int paraNumber) async {
    // Get Juz ayahs directly from the locally cached full Quran data service
    return await _dataService.getJuzAyahs(paraNumber);
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
}
