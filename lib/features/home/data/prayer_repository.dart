import 'dart:convert';
import 'package:deen/core/models/prayer_timings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class PrayerRepository {
  Future<String> getCurrentAddress() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    final pos = await Geolocator.getCurrentPosition();
    try {
      final places = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      if (places.isNotEmpty) {
        final place = places.first;
        return "${place.locality}, ${place.country}";
      }
    } catch (e) {
      // Fallback if geocoding fails
      return "Current Location";
    }
    return "Current Location";
  }

  Future<PrayerTimings> fetchPrayerTimings(String address) async {
    final now = DateTime.now();
    final date =
        "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
    final url = Uri.parse(
      "https://api.aladhan.com/v1/timingsByAddress/$date?address=$address&method=8",
    );

    final res = await http.get(url);
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return PrayerTimings.fromJson(json['data']);
    } else {
      throw Exception("Failed to fetch prayer timings");
    }
  }
}
