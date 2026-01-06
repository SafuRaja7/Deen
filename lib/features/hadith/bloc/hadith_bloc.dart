import 'package:deen/features/hadith/data/models/hadith.dart';
import 'package:deen/features/hadith/data/repository/hadith_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/hadith/bloc/hadith_event.dart';
import 'package:deen/features/hadith/bloc/hadith_state.dart';

class HadithBloc extends Bloc<HadithEvent, HadithState> {
  final HadithRepository _repository = HadithRepository();

  HadithBloc() : super(const HadithState()) {
    on<LoadHadithData>(_onLoadHadithData);
    on<LoadHadithChapters>(_onLoadHadithChapters);
    on<LoadHadiths>(_onLoadHadiths);
  }

  Future<void> _onLoadHadithData(
    LoadHadithData event,
    Emitter<HadithState> emit,
  ) async {
    emit(state.copyWith(status: HadithStatus.loading));
    try {
      // TODO: Implement data loading logic
      emit(state.copyWith(status: HadithStatus.success));
    } catch (e) {
      emit(state.copyWith(status: HadithStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onLoadHadithChapters(
    LoadHadithChapters event,
    Emitter<HadithState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HadithStatus.loading,
        selectedBookSlug: event.bookSlug,
      ),
    );
    try {
      final chapters = await _repository.fetchChapters(event.bookSlug);
      emit(state.copyWith(status: HadithStatus.success, chapters: chapters));
    } catch (e) {
      emit(state.copyWith(status: HadithStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onLoadHadiths(
    LoadHadiths event,
    Emitter<HadithState> emit,
  ) async {
    if (event.loadMore) {
      if (!state.hasMore || state.loadingMore) return;
      emit(state.copyWith(loadingMore: true));
    }

    final nextPage = event.loadMore ? state.currentPage + 1 : 1;

    try {
      if (!event.loadMore) {
        emit(
          state.copyWith(
            status: HadithStatus.loading,
            hadiths: [],
            currentPage: 1,
            hasMore: true,
            loadingMore: false,
          ),
        );
      }

      final response = await _repository.fetchHadiths(
        bookSlug: event.bookSlug,
        chapterNumber: event.chapterNumber,
        page: nextPage,
      );

      final List<Hadith> fetchedHadiths = response['hadiths'];
      final int currentPage = response['currentPage'];
      final int lastPage = response['lastPage'];

      emit(
        state.copyWith(
          status: HadithStatus.success,
          hadiths: event.loadMore
              ? [...state.hadiths, ...fetchedHadiths]
              : fetchedHadiths,
          currentPage: currentPage,
          hasMore: currentPage < lastPage,
          loadingMore: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HadithStatus.failure,
          error: e.toString(),
          loadingMore: false,
        ),
      );
    }
  }
}
