import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/prayer_timings/bloc/prayer_timings_event.dart';
import 'package:deen/features/prayer_timings/bloc/prayer_timings_state.dart';
import 'package:deen/features/prayer_timings/data/prayer_timings_repo.dart';

class PrayerTimingsBloc extends Bloc<PrayerTimingsEvent, PrayerTimingsState> {
  final PrayerTimingsRepository _repository;

  PrayerTimingsBloc({
    required PrayerTimingsRepository repository,
    required int initialMonth,
    required int initialYear,
    required String initialAddress,
  }) : _repository = repository,
       super(
         PrayerTimingsState(
           selectedMonth: initialMonth,
           selectedYear: initialYear,
           address: initialAddress,
         ),
       ) {
    on<LoadMonthlyTimings>(_onLoadMonthlyTimings);
    on<ChangeTimingsMonth>(_onChangeTimingsMonth);
  }

  Future<void> _onLoadMonthlyTimings(
    LoadMonthlyTimings event,
    Emitter<PrayerTimingsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: PrayerTimingsStatus.loading,
        address: event.address,
        selectedMonth: event.month,
        selectedYear: event.year,
      ),
    );

    try {
      final monthlyTimings = await _repository.fetchMonthlyPrayerTimings(
        event.address,
        event.month,
        event.year,
      );
      emit(
        state.copyWith(
          status: PrayerTimingsStatus.success,
          monthlyTimings: monthlyTimings,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PrayerTimingsStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  void _onChangeTimingsMonth(
    ChangeTimingsMonth event,
    Emitter<PrayerTimingsState> emit,
  ) {
    int newMonth = state.selectedMonth + event.delta;
    int newYear = state.selectedYear;

    if (newMonth > 12) {
      newMonth = 1;
      newYear++;
    } else if (newMonth < 1) {
      newMonth = 12;
      newYear--;
    }

    add(
      LoadMonthlyTimings(
        address: state.address,
        month: newMonth,
        year: newYear,
      ),
    );
  }
}
