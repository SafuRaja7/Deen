part of '../presentation/surah_details_screen.dart';

abstract class SurahDetailsEvent extends Equatable {
  const SurahDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSurahDetailsData extends SurahDetailsEvent {
  final int surahNumber;
  const LoadSurahDetailsData(this.surahNumber);

  @override
  List<Object?> get props => [surahNumber];
}

class LoadMoreAyahs extends SurahDetailsEvent {}
