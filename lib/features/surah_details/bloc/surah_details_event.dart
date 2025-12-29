part of '../presentation/surah_details_screen.dart';

abstract class SurahDetailsEvent extends Equatable {
  const SurahDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSurahDetailsData extends SurahDetailsEvent {
  final int surahNumber;
  final int? initialAyahNumber;
  const LoadSurahDetailsData(this.surahNumber, {this.initialAyahNumber});

  @override
  List<Object?> get props => [surahNumber, initialAyahNumber];
}

class LoadMoreAyahs extends SurahDetailsEvent {}

class PlayAyahAudio extends SurahDetailsEvent {
  final int ayahNumber;
  const PlayAyahAudio(this.ayahNumber);

  @override
  List<Object?> get props => [ayahNumber];
}

class ToggleAyahAudio extends SurahDetailsEvent {}

class UpdateAudioProgress extends SurahDetailsEvent {
  final Duration position;
  final Duration duration;
  final bool isPlaying;
  final bool isAudioLoading;

  const UpdateAudioProgress({
    required this.position,
    required this.duration,
    required this.isPlaying,
    required this.isAudioLoading,
  });

  @override
  List<Object?> get props => [position, duration, isPlaying, isAudioLoading];
}

class SeekAudio extends SurahDetailsEvent {
  final Duration position;
  const SeekAudio(this.position);

  @override
  List<Object?> get props => [position];
}

class CloseAudioPlayer extends SurahDetailsEvent {}
