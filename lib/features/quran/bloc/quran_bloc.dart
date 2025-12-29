import 'package:deen/features/quran/data/quran_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/quran/bloc/quran_event.dart';
import 'package:deen/features/quran/bloc/quran_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  final QuranRepository _quranRepository;

  QuranBloc({QuranRepository? quranRepository})
    : _quranRepository = quranRepository ?? QuranRepository(),
      super(const QuranState()) {
    on<LoadQuranData>(_onLoadQuranData);
    on<ChangeQuranTab>(_onChangeQuranTab);
  }

  void _onChangeQuranTab(ChangeQuranTab event, Emitter<QuranState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  Future<void> _onLoadQuranData(
    LoadQuranData event,
    Emitter<QuranState> emit,
  ) async {
    emit(state.copyWith(status: QuranStatus.loading));
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastPlayedSurahName = prefs.getString('cached_surah_name');
      final lastPlayedSurahNumber = prefs.getInt('cached_surah_number');
      final lastPlayedAyahNumber = prefs.getInt('cached_ayah_number');

      final surahs = await _quranRepository.fetchSurahs();
      emit(
        state.copyWith(
          status: QuranStatus.success,
          surahs: surahs,
          lastPlayedSurahName: lastPlayedSurahName,
          lastPlayedSurahNumber: lastPlayedSurahNumber,
          lastPlayedAyahNumber: lastPlayedAyahNumber,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: QuranStatus.failure, error: e.toString()));
    }
  }
}
