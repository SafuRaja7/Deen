import 'dart:convert';
import 'package:deen/core/models/surah.dart';
import 'package:http/http.dart' as http;

class QuranRepository {
  static const String _baseUrl = 'http://api.alquran.cloud/v1';

  Future<List<Surah>> fetchSurahs() async {
    final response = await http.get(Uri.parse('$_baseUrl/surah'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> surahsJson = data['data'];
      return surahsJson.map((json) => Surah.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load surahs');
    }
  }
}
