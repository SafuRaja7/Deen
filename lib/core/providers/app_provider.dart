import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:deen/core/models/prayer_timings.dart';
import 'package:deen/core/models/ayah.dart';
import 'package:deen/features/home/data/prayer_repository.dart';
import 'package:deen/features/prayer_timings/data/prayer_timings_repo.dart';
import 'package:deen/features/home/data/verse_repository.dart';
import 'package:deen/features/home/data/reflection_repository.dart';

class AppProvider extends ChangeNotifier {
  final PrayerRepository _prayerRepository = PrayerRepository();
  final PrayerTimingsRepository _prayerTimingsRepository =
      PrayerTimingsRepository();
  final VerseOfTheDayRepository _verseRepository = VerseOfTheDayRepository();
  final ReflectionRepository _reflectionRepository = ReflectionRepository();

  // Prayer Timings State
  PrayerTimings? _timings;
  String _address = "Fetching location...";
  bool _isPrayerLoading = false;
  String? _prayerError;
  String _currentPrayer = "Fajr";
  Duration _timeLeft = Duration.zero;
  Timer? _prayerTimer;

  // Monthly Prayer Timings State
  List<PrayerTimings> _monthlyTimings = [];
  int _selectedMonth = DateTime.now().month;
  int _selectedYear = DateTime.now().year;
  bool _isMonthlyLoading = false;

  // Verse State
  Ayah? _verseOfTheDay;
  bool _isVerseLoading = false;
  String? _verseError;

  // Reflection State
  Ayah? _reflectionOfTheDay;
  bool _isReflectionLoading = false;
  String? _reflectionError;

  // Getters
  PrayerTimings? get timings => _timings;
  String get address => _address;
  bool get isPrayerLoading => _isPrayerLoading;
  String? get prayerError => _prayerError;
  String get currentPrayer => _currentPrayer;
  Duration get timeLeft => _timeLeft;

  Ayah? get verseOfTheDay => _verseOfTheDay;
  bool get isVerseLoading => _isVerseLoading;
  String? get verseError => _verseError;

  Ayah? get reflectionOfTheDay => _reflectionOfTheDay;
  bool get isReflectionLoading => _isReflectionLoading;
  String? get reflectionError => _reflectionError;

  List<PrayerTimings> get monthlyTimings => _monthlyTimings;
  int get selectedMonth => _selectedMonth;
  int get selectedYear => _selectedYear;
  bool get isMonthlyLoading => _isMonthlyLoading;

  AppProvider() {
    _init();
  }

  Future<void> _init() async {
    await Future.wait([
      fetchPrayerTimings(),
      fetchMonthlyTimings(_selectedMonth, _selectedYear),
      fetchVerseOfTheDay(),
      fetchReflectionOfTheDay(),
    ]);
    _startPrayerTimer();
  }

  // Prayer Logic
  Future<void> fetchPrayerTimings() async {
    _isPrayerLoading = true;
    _prayerError = null;
    notifyListeners();

    try {
      _address = await _prayerRepository.getCurrentAddress();
      _timings = await _prayerRepository.fetchPrayerTimings(_address);
      _updateCurrentPrayer();
    } catch (e) {
      _prayerError = e.toString();
    } finally {
      _isPrayerLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMonthlyTimings(int month, int year) async {
    _isMonthlyLoading = true;
    _prayerError = null;
    notifyListeners();

    try {
      if (_address == "Fetching location...") {
        _address = await _prayerRepository.getCurrentAddress();
      }
      _monthlyTimings = await _prayerTimingsRepository
          .fetchMonthlyPrayerTimings(_address, month, year);
    } catch (e) {
      _prayerError = e.toString();
    } finally {
      _isMonthlyLoading = false;
      notifyListeners();
    }
  }

  void changeMonth(int delta) {
    int newMonth = _selectedMonth + delta;
    int newYear = _selectedYear;

    if (newMonth > 12) {
      newMonth = 1;
      newYear++;
    } else if (newMonth < 1) {
      newMonth = 12;
      newYear--;
    }

    _selectedMonth = newMonth;
    _selectedYear = newYear;
    fetchMonthlyTimings(_selectedMonth, _selectedYear);
  }

  void _startPrayerTimer() {
    _prayerTimer?.cancel();
    _prayerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
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

  // Verse Logic
  Future<void> fetchVerseOfTheDay() async {
    _isVerseLoading = true;
    _verseError = null;
    notifyListeners();

    try {
      _verseOfTheDay = await _verseRepository.getVerseOfTheDay();
    } catch (e) {
      _verseError = e.toString();
    } finally {
      _isVerseLoading = false;
      notifyListeners();
    }
  }

  // Reflection Logic
  Future<void> fetchReflectionOfTheDay() async {
    _isReflectionLoading = true;
    _reflectionError = null;
    notifyListeners();

    try {
      _reflectionOfTheDay = await _reflectionRepository.getReflectionOfTheDay();
    } catch (e) {
      _reflectionError = e.toString();
    } finally {
      _isReflectionLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _prayerTimer?.cancel();
    super.dispose();
  }
}
