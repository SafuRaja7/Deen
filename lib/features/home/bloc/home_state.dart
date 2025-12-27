import 'package:equatable/equatable.dart';
import 'package:deen/core/models/prayer_timings.dart';
import 'package:deen/core/models/ayah.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final PrayerTimings? timings;
  final String address;
  final Ayah? verseOfTheDay;
  final Ayah? reflectionOfTheDay;
  final String currentPrayer;
  final Duration timeLeft;
  final String? error;

  const HomeState({
    this.status = HomeStatus.initial,
    this.timings,
    this.address = "Fetching location...",
    this.verseOfTheDay,
    this.reflectionOfTheDay,
    this.currentPrayer = "Fajr",
    this.timeLeft = Duration.zero,
    this.error,
  });

  HomeState copyWith({
    HomeStatus? status,
    PrayerTimings? timings,
    String? address,
    Ayah? verseOfTheDay,
    Ayah? reflectionOfTheDay,
    String? currentPrayer,
    Duration? timeLeft,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      timings: timings ?? this.timings,
      address: address ?? this.address,
      verseOfTheDay: verseOfTheDay ?? this.verseOfTheDay,
      reflectionOfTheDay: reflectionOfTheDay ?? this.reflectionOfPeace,
      currentPrayer: currentPrayer ?? this.currentPrayer,
      timeLeft: timeLeft ?? this.timeLeft,
      error: error ?? this.error,
    );
  }

  // Helper getter to avoid confusion with naming in copyWith if needed
  Ayah? get reflectionOfPeace => reflectionOfTheDay;

  @override
  List<Object?> get props => [
    status,
    timings,
    address,
    verseOfTheDay,
    reflectionOfTheDay,
    currentPrayer,
    timeLeft,
    error,
  ];
}
