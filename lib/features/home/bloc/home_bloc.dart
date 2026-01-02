import 'dart:async';
import 'package:deen/features/home/data/home_repository.dart';
import 'package:deen/features/home/bloc/home_event.dart';
import 'package:deen/features/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;
  Timer? _timer;

  HomeBloc({required HomeRepository homeRepository})
    : _homeRepository = homeRepository,
      super(const HomeState()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<UpdatePrayerTimer>(_onUpdatePrayerTimer);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      // 1. Try to load from cache first for immediate display
      final cachedLocation = await _homeRepository.getCachedLocation();
      final history = await _homeRepository.getLocationHistory();

      final entry = history.cast<dynamic>().firstWhere(
        (e) => e.location == cachedLocation,
        orElse: () => null,
      );

      if (entry != null && entry.timings.isNotEmpty) {
        final timings = entry.timings.last;
        final verse = await _homeRepository.getVerseOfTheDay();
        final reflection = await _homeRepository.getReflectionOfTheDay();

        emit(
          state.copyWith(
            status: HomeStatus.success,
            address: cachedLocation,
            timings: timings,
            verseOfTheDay: verse,
            reflectionOfTheDay: reflection,
          ),
        );

        _startTimer();
        add(UpdatePrayerTimer());

        // Background Refresh: Check if we actually moved
        try {
          final freshAddress = await _homeRepository.getCurrentAddress();
          if (freshAddress != cachedLocation) {
            final freshTimings = await _homeRepository.fetchPrayerTimings(
              freshAddress,
            );
            if (!isClosed) {
              emit(
                state.copyWith(address: freshAddress, timings: freshTimings),
              );
              add(UpdatePrayerTimer());
            }
          }
        } catch (_) {}
      } else {
        // No cache, force fetch
        final address = await _homeRepository.getCurrentAddress();
        final timings = await _homeRepository.fetchPrayerTimings(address);
        final verse = await _homeRepository.getVerseOfTheDay();
        final reflection = await _homeRepository.getReflectionOfTheDay();

        if (!isClosed) {
          emit(
            state.copyWith(
              status: HomeStatus.success,
              address: address,
              timings: timings,
              verseOfTheDay: verse,
              reflectionOfTheDay: reflection,
            ),
          );
          _startTimer();
          add(UpdatePrayerTimer());
        }
      }
    } catch (e) {
      if (!isClosed && state.status != HomeStatus.success) {
        emit(state.copyWith(status: HomeStatus.failure, error: e.toString()));
      }
    }
  }

  void _onUpdatePrayerTimer(UpdatePrayerTimer event, Emitter<HomeState> emit) {
    if (state.timings == null) return;

    final now = DateTime.now();
    final format = DateFormat("HH:mm");
    final keys = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

    DateTime? nextTime;
    String current = "Isha";

    for (int i = 0; i < keys.length; i++) {
      final timeStr = state.timings!.timings[keys[i]];
      if (timeStr == null) continue;

      try {
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
      } catch (_) {}
    }

    if (nextTime == null) {
      try {
        final fajrStr = state.timings!.timings['Fajr']!;
        final time = format.parse(fajrStr);
        nextTime = DateTime(
          now.year,
          now.month,
          now.day + 1,
          time.hour,
          time.minute,
        );
        current = "Isha";
      } catch (_) {
        nextTime = now.add(const Duration(hours: 1));
      }
    }

    emit(
      state.copyWith(
        currentPrayer: current,
        timeLeft: nextTime.difference(now),
      ),
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isClosed) {
        add(UpdatePrayerTimer());
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
