import 'dart:convert';
import 'package:deen/core/constants/api_constants.dart';
import 'package:deen/features/hadith/data/models/hadith.dart';
import 'package:deen/features/hadith/data/models/hadith_chapter.dart';
import 'package:http/http.dart' as http;

class HadithRepository {
  Future<List<HadithChapter>> fetchChapters(String bookSlug) async {
    final url = Uri.parse(
      '${ApiConstants.hadithBaseUrl}/$bookSlug/chapters?apiKey=${ApiConstants.hadithApiKey}',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> chaptersJson = data['chapters'];
        return chaptersJson
            .map((json) => HadithChapter.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load chapters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching chapters: $e');
    }
  }

  Future<Map<String, dynamic>> fetchHadiths({
    required String bookSlug,
    required String chapterNumber,
    int page = 1,
  }) async {
    final url = Uri.parse(
      '${ApiConstants.hadithBaseUrl}/hadiths/?apiKey=${ApiConstants.hadithApiKey}&book=$bookSlug&chapter=$chapterNumber&paginate=10&page=$page',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final hadithsJson = data['hadiths']['data'] as List;
        final hadiths = hadithsJson
            .map((json) => Hadith.fromJson(json))
            .toList();

        return {
          'hadiths': hadiths,
          'currentPage': data['hadiths']['current_page'],
          'lastPage': data['hadiths']['last_page'],
          'total': data['hadiths']['total'],
        };
      } else {
        throw Exception('Failed to load hadiths: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching hadiths: $e');
    }
  }
}
