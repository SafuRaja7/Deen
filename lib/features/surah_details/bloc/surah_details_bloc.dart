part of '../presentation/surah_details_screen.dart';

class SurahDetailsBloc extends Bloc<SurahDetailsEvent, SurahDetailsState> {
  final SurahDetailsRepository _repository;

  SurahDetailsBloc({SurahDetailsRepository? repository})
    : _repository = repository ?? SurahDetailsRepository(),
      super(const SurahDetailsState()) {
    on<LoadSurahDetailsData>(_onLoadSurahDetailsData);
    on<LoadMoreAyahs>(_onLoadMoreAyahs);
  }

  Future<void> _onLoadSurahDetailsData(
    LoadSurahDetailsData event,
    Emitter<SurahDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SurahDetailsStatus.loading,
        surahNumber: event.surahNumber,
        hasMore: true,
      ),
    );
    try {
      final surahDetail = await _repository.fetchSurahDetail(
        event.surahNumber,
        offset: 0,
        limit: 5,
      );
      emit(
        state.copyWith(
          status: SurahDetailsStatus.success,
          surahDetail: surahDetail,
          hasMore: surahDetail.ayahs.length == 5,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: SurahDetailsStatus.failure, error: e.toString()),
      );
    }
  }

  Future<void> _onLoadMoreAyahs(
    LoadMoreAyahs event,
    Emitter<SurahDetailsState> emit,
  ) async {
    if (state.status != SurahDetailsStatus.success ||
        state.loadingMore ||
        !state.hasMore ||
        state.surahDetail == null) {
      return;
    }

    emit(state.copyWith(loadingMore: true));

    try {
      final int offset = state.surahDetail!.ayahs.length;
      final nextSurahDetail = await _repository.fetchSurahDetail(
        state.surahNumber!,
        offset: offset,
        limit: 5,
      );

      final combinedAyahs = [
        ...state.surahDetail!.ayahs,
        ...nextSurahDetail.ayahs,
      ];
      print("Ayahs length: ${combinedAyahs.length}");

      emit(
        state.copyWith(
          loadingMore: false,
          surahDetail: SurahDetail(
            number: state.surahDetail!.number,
            name: state.surahDetail!.name,
            englishName: state.surahDetail!.englishName,
            englishNameTranslation: state.surahDetail!.englishNameTranslation,
            revelationType: state.surahDetail!.revelationType,
            numberOfAyahs: state.surahDetail!.numberOfAyahs,
            ayahs: combinedAyahs,
          ),
          hasMore: nextSurahDetail.ayahs.length == 5,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadingMore: false, error: e.toString()));
    }
  }
}
