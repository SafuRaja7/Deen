import 'package:deen/core/models/ayah.dart';
import 'package:equatable/equatable.dart';

enum SurahDetailsStatus { initial, loading, success, failure }

class SurahDetailsState extends Equatable {
  final SurahDetailsStatus status;
  final SurahDetail? surahDetail;
  final String? error;
  final bool hasMore;
  final bool loadingMore;
  final int? surahNumber;

  // Audio related
  final int? playingAyahNumber;
  final int? numberInSurah;
  final bool isPlaying;
  final bool isAudioLoading;
  final Duration position;
  final Duration duration;
  final String? audioFilePath;
  final int? initialAyahNumberInSurah;

  const SurahDetailsState({
    this.status = SurahDetailsStatus.initial,
    this.surahDetail,
    this.error,
    this.hasMore = true,
    this.loadingMore = false,
    this.surahNumber,
    this.playingAyahNumber,
    this.numberInSurah,
    this.isPlaying = false,
    this.isAudioLoading = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.audioFilePath,
    this.initialAyahNumberInSurah,
  });

  SurahDetailsState copyWith({
    SurahDetailsStatus? status,
    SurahDetail? surahDetail,
    String? error,
    bool? hasMore,
    bool? loadingMore,
    int? surahNumber,
    int? playingAyahNumber,
    int? numberInSurah,
    bool? isPlaying,
    bool? isAudioLoading,
    Duration? position,
    Duration? duration,
    String? audioFilePath,
    int? initialAyahNumberInSurah,
  }) {
    return SurahDetailsState(
      status: status ?? this.status,
      surahDetail: surahDetail ?? this.surahDetail,
      error: error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      surahNumber: surahNumber ?? this.surahNumber,
      playingAyahNumber: playingAyahNumber ?? this.playingAyahNumber,
      numberInSurah: numberInSurah ?? this.numberInSurah,
      isPlaying: isPlaying ?? this.isPlaying,
      isAudioLoading: isAudioLoading ?? this.isAudioLoading,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      audioFilePath: audioFilePath ?? this.audioFilePath,
      initialAyahNumberInSurah:
          initialAyahNumberInSurah ?? this.initialAyahNumberInSurah,
    );
  }

  SurahDetailsState clearPlayer() {
    return copyWith(
      playingAyahNumber: null,
      numberInSurah: null,
      isPlaying: false,
      isAudioLoading: false,
      position: Duration.zero,
      duration: Duration.zero,
      audioFilePath: null,
    );
  }

  @override
  List<Object?> get props => [
    status,
    surahDetail,
    error,
    hasMore,
    loadingMore,
    surahNumber,
    playingAyahNumber,
    numberInSurah,
    isPlaying,
    isAudioLoading,
    position,
    duration,
    audioFilePath,
    initialAyahNumberInSurah,
  ];
}
