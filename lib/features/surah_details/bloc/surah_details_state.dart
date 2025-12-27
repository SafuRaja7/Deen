part of '../presentation/surah_details_screen.dart';

enum SurahDetailsStatus { initial, loading, success, failure }

class SurahDetailsState extends Equatable {
  final int? surahNumber;
  final SurahDetail? surahDetail;
  final SurahDetailsStatus status;
  final bool hasMore;
  final bool loadingMore;
  final String? error;

  const SurahDetailsState({
    this.surahNumber,
    this.surahDetail,
    this.status = SurahDetailsStatus.initial,
    this.hasMore = true,
    this.loadingMore = false,
    this.error,
  });

  SurahDetailsState copyWith({
    int? surahNumber,
    SurahDetail? surahDetail,
    SurahDetailsStatus? status,
    bool? hasMore,
    bool? loadingMore,
    String? error,
  }) {
    return SurahDetailsState(
      surahNumber: surahNumber ?? this.surahNumber,
      surahDetail: surahDetail ?? this.surahDetail,
      status: status ?? this.status,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    surahNumber,
    surahDetail,
    status,
    hasMore,
    loadingMore,
    error,
  ];
}
