import 'package:equatable/equatable.dart';

abstract class PrayerTimingsEvent extends Equatable {
  const PrayerTimingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadMonthlyTimings extends PrayerTimingsEvent {
  final String address;
  final int month;
  final int year;

  const LoadMonthlyTimings({
    required this.address,
    required this.month,
    required this.year,
  });

  @override
  List<Object?> get props => [address, month, year];
}

class ChangeTimingsMonth extends PrayerTimingsEvent {
  final int delta;

  const ChangeTimingsMonth(this.delta);

  @override
  List<Object?> get props => [delta];
}
