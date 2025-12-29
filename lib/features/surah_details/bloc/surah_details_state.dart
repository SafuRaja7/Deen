part of '../presentation/surah_details_screen.dart';

enum SurahDetailsStatus { initial, loading, success, failure }

class SurahDetailsState extends Equatable {
  final int? surahNumber;
  final SurahDetail? surahDetail;
  final SurahDetailsStatus status;
  final bool hasMore;
  final bool loadingMore;
  final String? error;
  final int? playingAyahNumber;
  final int? initialAyahNumberInSurah;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final bool isAudioLoading;
  final bool isDownloading;
  final String? audioFilePath;
  final int? numberInSurah;

  const SurahDetailsState({
    this.surahNumber,
    this.surahDetail,
    this.status = SurahDetailsStatus.initial,
    this.hasMore = true,
    this.loadingMore = false,
    this.error,
    this.playingAyahNumber,
    this.initialAyahNumberInSurah,
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isAudioLoading = false,
    this.isDownloading = false,
    this.audioFilePath,
    this.numberInSurah,
  });

  bool get isAnyLoading => isAudioLoading || isDownloading;

  SurahDetailsState copyWith({
    int? surahNumber,
    SurahDetail? surahDetail,
    SurahDetailsStatus? status,
    bool? hasMore,
    bool? loadingMore,
    String? error,
    int? playingAyahNumber,
    int? initialAyahNumberInSurah,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    bool? isAudioLoading,
    bool? isDownloading,
    String? audioFilePath,
    int? numberInSurah,
  }) {
    return SurahDetailsState(
      surahNumber: surahNumber ?? this.surahNumber,
      surahDetail: surahDetail ?? this.surahDetail,
      status: status ?? this.status,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      error: error ?? this.error,
      playingAyahNumber: playingAyahNumber ?? this.playingAyahNumber,
      initialAyahNumberInSurah:
          initialAyahNumberInSurah ?? this.initialAyahNumberInSurah,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isAudioLoading: isAudioLoading ?? this.isAudioLoading,
      isDownloading: isDownloading ?? this.isDownloading,
      audioFilePath: audioFilePath ?? this.audioFilePath,
      numberInSurah: numberInSurah ?? this.numberInSurah,
    );
  }

  SurahDetailsState clearPlayer() {
    return SurahDetailsState(
      surahNumber: surahNumber,
      surahDetail: surahDetail,
      status: status,
      hasMore: hasMore,
      loadingMore: loadingMore,
      error: error,
      playingAyahNumber: null,
      initialAyahNumberInSurah: null,
      isPlaying: false,
      position: Duration.zero,
      duration: Duration.zero,
      isAudioLoading: false,
      isDownloading: false,
      audioFilePath: null,
      numberInSurah: numberInSurah,
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
    playingAyahNumber,
    initialAyahNumberInSurah,
    isPlaying,
    position,
    duration,
    isAudioLoading,
    isDownloading,
    audioFilePath,
    numberInSurah,
  ];
}
