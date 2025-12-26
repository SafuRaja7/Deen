import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/models/prayer_timings.dart';
import '../../data/prayer_repository.dart';

class PrayerProvider extends ChangeNotifier {
  final PrayerRepository _repository = PrayerRepository();

  PrayerTimings? _timings;
  String _address = "Fetching location...";
  bool _isLoading = false;
  String? _error;

  String _currentPrayer = "Fajr";
  Duration _timeLeft = Duration.zero;
  Timer? _timer;

  PrayerTimings? get timings => _timings;
  String get address => _address;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get currentPrayer => _currentPrayer;
  Duration get timeLeft => _timeLeft;

  PrayerProvider() {
    _init();
  }

  Future<void> _init() async {
    await fetchTimings();
    _startTimer();
  }

  Future<void> fetchTimings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _address = await _repository.getCurrentAddress();
      _timings = await _repository.fetchPrayerTimings(_address);
      _updateCurrentPrayer();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCurrentPrayer();
    });
  }

  void _updateCurrentPrayer() {
    if (_timings == null) return;

    final now = DateTime.now();
    final format = DateFormat("HH:mm");

    final keys = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

    DateTime? nextTime;
    String current = "Isha";

    for (int i = 0; i < keys.length; i++) {
      final timeStr = _timings!.timings[keys[i]];
      if (timeStr == null) continue;

      final time = format.parse(timeStr);
      final dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );

      if (now.isBefore(dateTime)) {
        nextTime = dateTime;
        if (i > 0) {
          current = keys[i - 1];
        } else {
          current = "Isha";
        }
        break;
      }
    }

    if (nextTime == null) {
      final fajrStr = _timings!.timings['Fajr']!;
      final time = format.parse(fajrStr);
      nextTime = DateTime(
        now.year,
        now.month,
        now.day + 1,
        time.hour,
        time.minute,
      );
      current = "Isha";
    }

    _currentPrayer = current;
    _timeLeft = nextTime.difference(now);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
