import 'dart:convert';
import 'package:deen/core/models/prayer_timings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PrayerTimingsRepository {
  static const String _kMonthlyCachePrefix = 'monthly_timings';

  Future<List<PrayerTimings>> fetchMonthlyPrayerTimings(
    String address,
    int month,
    int year,
  ) async {
    final cacheKey = '${_kMonthlyCachePrefix}_${address}_${month}_$year';
    final prefs = await SharedPreferences.getInstance();

    // Try to get from cache first
    final cachedData = prefs.getString(cacheKey);
    if (cachedData != null) {
      try {
        final List decoded = jsonDecode(cachedData);
        return decoded.map((day) => PrayerTimings.fromJson(day)).toList();
      } catch (e) {
        // Fallback to fetch if cache is corrupted
      }
    }

    final url = Uri.parse(
      "https://api.aladhan.com/v1/calendarByAddress?address=$address&method=8&month=$month&year=$year",
    );

    try {
      final res = await http.get(url).timeout(const Duration(seconds: 10));
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        final List data = json['data'];

        await prefs.setString(cacheKey, jsonEncode(data));

        return data.map((day) => PrayerTimings.fromJson(day)).toList();
      } else {
        throw Exception("Failed to fetch monthly prayer timings");
      }
    } catch (e) {
      if (cachedData != null) {
        final List decoded = jsonDecode(cachedData);
        return decoded.map((day) => PrayerTimings.fromJson(day)).toList();
      }
      throw Exception(
        "No internet and no cached data available for $month/$year at $address",
      );
    }
  }
}
