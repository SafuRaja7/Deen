import 'dart:convert';
import 'package:deen/core/models/prayer_timings.dart';
import 'package:http/http.dart' as http;

class PrayerTimingsRepository {
  Future<List<PrayerTimings>> fetchMonthlyPrayerTimings(
    String address,
    int month,
    int year,
  ) async {
    final url = Uri.parse(
      "https://api.aladhan.com/v1/calendarByAddress?address=$address&method=8&month=$month&year=$year",
    );

    final res = await http.get(url);
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      final List data = json['data'];
      return data.map((day) => PrayerTimings.fromJson(day)).toList();
    } else {
      throw Exception("Failed to fetch monthly prayer timings");
    }
  }
}
