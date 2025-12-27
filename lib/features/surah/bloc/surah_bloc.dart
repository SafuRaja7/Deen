import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/surah/bloc/surah_event.dart';
import 'package:deen/features/surah/bloc/surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  SurahBloc() : super(const SurahState()) {
    on<LoadSurahData>(_onLoadSurahData);
  }

  Future<void> _onLoadSurahData(
    LoadSurahData event,
    Emitter<SurahState> emit,
  ) async {
    emit(state.copyWith(status: SurahStatus.loading));
    try {
      // TODO: Implement data loading logic
      emit(state.copyWith(status: SurahStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: SurahStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
