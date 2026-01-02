class HijriDate {
  final String day;
  final String month;
  final String year;
  final String full;

  HijriDate({
    required this.day,
    required this.month,
    required this.year,
    required this.full,
  });

  factory HijriDate.fromJson(Map<String, dynamic> json) {
    return HijriDate(
      day: json['day'],
      month: json['month'] is Map ? json['month']['en'] : json['month'],
      year: json['year'],
      full: json['date'] ?? json['full'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'day': day, 'month': month, 'year': year, 'full': full};
  }
}

class PrayerTimings {
  final Map<String, String> timings;
  final HijriDate hijri;

  PrayerTimings({required this.timings, required this.hijri});

  factory PrayerTimings.fromJson(Map<String, dynamic> data) {
    final timingsMap = Map<String, String>.from(data['timings']);
    final hijriData = data['date'] != null
        ? data['date']['hijri']
        : data['hijri'];
    return PrayerTimings(
      timings: timingsMap,
      hijri: HijriDate.fromJson(hijriData),
    );
  }

  Map<String, dynamic> toJson() {
    return {'timings': timings, 'hijri': hijri.toJson()};
  }
}
