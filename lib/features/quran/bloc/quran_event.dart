import 'package:equatable/equatable.dart';

abstract class QuranEvent extends Equatable {
  const QuranEvent();

  @override
  List<Object?> get props => [];
}

class LoadQuranData extends QuranEvent {}

class ChangeQuranTab extends QuranEvent {
  final int index;
  const ChangeQuranTab(this.index);

  @override
  List<Object?> get props => [index];
}

class ToggleBookmark extends QuranEvent {
  final int surahNumber;
  final int ayahNumberInSurah;
  const ToggleBookmark(this.surahNumber, this.ayahNumberInSurah);

  @override
  List<Object?> get props => [surahNumber, ayahNumberInSurah];
}
