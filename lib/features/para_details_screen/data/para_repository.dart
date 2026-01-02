import 'dart:convert';
import 'package:deen/core/models/ayah.dart';
import 'package:http/http.dart' as http;

class ParaRepository {
  static final Map<int, List<AyahDetail>> _cache = {};

  Future<List<AyahDetail>> fetchPara(int paraNumber) async {
    if (_cache.containsKey(paraNumber)) {
      return _cache[paraNumber]!;
    }

    final url = Uri.parse('http://api.alquran.cloud/v1/quran/quran-uthmani');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final surahs = data['data']['surahs'] as List;

      List<AyahDetail> allAyahs = [];
      for (var surah in surahs) {
        final ayahs = surah['ayahs'] as List;
        for (var ayah in ayahs) {
          if (ayah['juz'] == paraNumber) {
            allAyahs.add(
              AyahDetail(
                number: ayah['number'],
                text: ayah['text'],
                translation: "", // This API doesn't provide translations
                numberInSurah: ayah['numberInSurah'],
                juz: ayah['juz'],
                page: ayah['page'],
              ),
            );
          }
        }
      }

      _cache[paraNumber] = allAyahs;
      return allAyahs;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
