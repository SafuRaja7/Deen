import 'prayer_timings.dart';

class LocationData {
  final String location;
  final List<PrayerTimings> timings;

  LocationData({required this.location, required this.timings});

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'timings': timings.map((e) => e.toJson()).toList(),
    };
  }

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      location: json['location'],
      timings: (json['timings'] as List)
          .map((e) => PrayerTimings.fromJson(e))
          .toList(),
    );
  }
}
