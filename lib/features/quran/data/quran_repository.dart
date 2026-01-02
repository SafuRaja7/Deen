import 'package:deen/core/models/surah.dart';
import 'package:deen/core/services/quran_data_service.dart';

class QuranRepository {
  final QuranDataService _dataService = QuranDataService();

  Future<List<Surah>> fetchSurahs() async {
    final fullQuran = await _dataService.getFullQuran();

    // Convert SurahDetail back to Surah model used by the main Quran tab
    return fullQuran
        .map(
          (s) => Surah(
            number: s.number,
            name: s.name,
            englishName: s.englishName,
            englishNameTranslation: s.englishNameTranslation,
            revelationType: s.revelationType,
            numberOfAyahs: s.numberOfAyahs,
          ),
        )
        .toList();
  }
}
