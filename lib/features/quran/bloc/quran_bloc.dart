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
    on<ToggleBookmark>(_onToggleBookmark);
  }

  void _onChangeQuranTab(ChangeQuranTab event, Emitter<QuranState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  Future<void> _onLoadQuranData(
    LoadQuranData event,
    Emitter<QuranState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Force reload to get the latest data from Ayah audio sessions
      await prefs.reload();

      // Stage 1: Load metadata immediately from SharedPreferences
      final lastPlayedSurahName = prefs.getString('cached_surah_name');
      final lastPlayedSurahNumber = prefs.getInt('cached_surah_number');
      final lastPlayedAyahNumber = prefs.getInt('cached_ayah_number');
      final lastPlayedGlobalAyahNumber = prefs.getInt(
        'cached_global_ayah_number',
      );

      final lastReadSurahName = prefs.getString('last_read_surah_name');
      final lastReadAyahNumber = prefs.getInt('last_read_ayah_number');
      final lastReadSurahNumber = prefs.getInt('last_read_surah_number');

      // Stage 2: Emit the metadata instantly.
      // This ensures the cards update AS SOON AS the user returns to the screen.
      emit(
        state.copyWith(
          lastPlayedSurahName: lastPlayedSurahName,
          lastPlayedSurahNumber: lastPlayedSurahNumber,
          lastPlayedAyahNumber: lastPlayedAyahNumber,
          lastPlayedGlobalAyahNumber: lastPlayedGlobalAyahNumber,
          lastReadSurahName: lastReadSurahName,
          lastReadSurahNumber: lastReadSurahNumber,
          lastReadAyahNumber: lastReadAyahNumber,
          bookmarkedAyahs: await _quranRepository.fetchBookmarkedAyahs(),
        ),
      );

      // Stage 3: Fetch the full Surah list only if it's missing or if we want to confirm status
      if (state.surahs.isEmpty) {
        emit(state.copyWith(status: QuranStatus.loading));
        final surahs = await _quranRepository.fetchSurahs();
        emit(state.copyWith(status: QuranStatus.success, surahs: surahs));
      } else {
        // We already have surahs, but we emit success to finish the cycle
        emit(state.copyWith(status: QuranStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: QuranStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onToggleBookmark(
    ToggleBookmark event,
    Emitter<QuranState> emit,
  ) async {
    await _quranRepository.toggleBookmark(
      event.surahNumber,
      event.ayahNumberInSurah,
    );
    final bookmarks = await _quranRepository.fetchBookmarkedAyahs();
    emit(state.copyWith(bookmarkedAyahs: bookmarks));
  }
}
