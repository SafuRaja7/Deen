import 'package:equatable/equatable.dart';

abstract class SurahDetailsEvent extends Equatable {
  const SurahDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSurahDetailsData extends SurahDetailsEvent {
  final int surahNumber;
  final int? initialAyahNumber;
  final int? initialAyahNumberInSurah;

  const LoadSurahDetailsData(
    this.surahNumber, {
    this.initialAyahNumber,
    this.initialAyahNumberInSurah,
  });

  @override
  List<Object?> get props => [
    surahNumber,
    initialAyahNumber,
    initialAyahNumberInSurah,
  ];
}

class LoadMoreAyahs extends SurahDetailsEvent {}

class PlayAyahAudio extends SurahDetailsEvent {
  final int ayahNumber;
  final int? numberInSurah;

  const PlayAyahAudio(this.ayahNumber, {this.numberInSurah});

  @override
  List<Object?> get props => [ayahNumber, numberInSurah];
}

class ToggleAyahAudio extends SurahDetailsEvent {}

class SeekAudio extends SurahDetailsEvent {
  final Duration position;
  const SeekAudio(this.position);

  @override
  List<Object?> get props => [position];
}

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

class CloseAudioPlayer extends SurahDetailsEvent {}
