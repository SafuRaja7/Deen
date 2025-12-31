import 'dart:convert';
import 'package:http/http.dart' as http;

class QiblaDirectionRepository {
  Future<double> fetchQiblaDirection({
    required double latitude,
    required double longitude,
  }) async {
    final url = Uri.parse(
      'https://api.aladhan.com/v1/qibla/$latitude/$longitude',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return (decoded['data']['direction'] as num).toDouble();
    } else {
      throw Exception('Failed to fetch Qibla direction');
    }
  }
}
