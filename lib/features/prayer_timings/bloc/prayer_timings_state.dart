import 'package:equatable/equatable.dart';
import 'package:deen/core/models/prayer_timings.dart';

enum PrayerTimingsStatus { initial, loading, success, failure }

class PrayerTimingsState extends Equatable {
  final PrayerTimingsStatus status;
  final List<PrayerTimings> monthlyTimings;
  final int selectedMonth;
  final int selectedYear;
  final String address;
  final String? error;

  const PrayerTimingsState({
    this.status = PrayerTimingsStatus.initial,
    this.monthlyTimings = const [],
    required this.selectedMonth,
    required this.selectedYear,
    this.address = "",
    this.error,
  });

  PrayerTimingsState copyWith({
    PrayerTimingsStatus? status,
    List<PrayerTimings>? monthlyTimings,
    int? selectedMonth,
    int? selectedYear,
    String? address,
    String? error,
  }) {
    return PrayerTimingsState(
      status: status ?? this.status,
      monthlyTimings: monthlyTimings ?? this.monthlyTimings,
      selectedMonth: selectedMonth ?? this.selectedMonth,
      selectedYear: selectedYear ?? this.selectedYear,
      address: address ?? this.address,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    monthlyTimings,
    selectedMonth,
    selectedYear,
    address,
    error,
  ];
}
