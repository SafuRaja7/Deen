part of '../presentation/surah_details_screen.dart';

class SurahDetailsRepository {
  static const String _baseUrl = 'http://api.alquran.cloud/v1';

  Future<SurahDetail> fetchSurahDetail(
    int number, {
    int offset = 0,
    int limit = 5,
  }) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl/surah/$number/editions/quran-uthmani,en.asad?offset=$offset&limit=$limit',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return SurahDetail.fromJson(data['data']);
    } else {
      throw Exception('Failed to load surah details');
    }
  }
}
