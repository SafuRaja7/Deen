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
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final bool isAudioLoading;
  final String? audioFilePath;

  const SurahDetailsState({
    this.surahNumber,
    this.surahDetail,
    this.status = SurahDetailsStatus.initial,
    this.hasMore = true,
    this.loadingMore = false,
    this.error,
    this.playingAyahNumber,
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isAudioLoading = false,
    this.audioFilePath,
  });

  SurahDetailsState copyWith({
    int? surahNumber,
    SurahDetail? surahDetail,
    SurahDetailsStatus? status,
    bool? hasMore,
    bool? loadingMore,
    String? error,
    int? playingAyahNumber,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    bool? isAudioLoading,
    String? audioFilePath,
  }) {
    return SurahDetailsState(
      surahNumber: surahNumber ?? this.surahNumber,
      surahDetail: surahDetail ?? this.surahDetail,
      status: status ?? this.status,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      error: error ?? this.error,
      playingAyahNumber: playingAyahNumber ?? this.playingAyahNumber,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isAudioLoading: isAudioLoading ?? this.isAudioLoading,
      audioFilePath: audioFilePath ?? this.audioFilePath,
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
    isPlaying,
    position,
    duration,
    isAudioLoading,
    audioFilePath,
  ];
}
