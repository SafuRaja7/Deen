import 'package:deen/core/models/surah.dart';
import 'package:equatable/equatable.dart';

enum QuranStatus { initial, loading, success, failure }

class QuranState extends Equatable {
  final QuranStatus status;
  final String? error;
  final int selectedIndex;
  final List<Surah> surahs;
  final String? lastPlayedSurahName;
  final int? lastPlayedSurahNumber;
  final int? lastPlayedAyahNumber;

  const QuranState({
    this.status = QuranStatus.initial,
    this.error,
    this.selectedIndex = 0,
    this.surahs = const [],
    this.lastPlayedSurahName,
    this.lastPlayedSurahNumber,
    this.lastPlayedAyahNumber,
  });

  QuranState copyWith({
    QuranStatus? status,
    String? error,
    int? selectedIndex,
    List<Surah>? surahs,
    String? lastPlayedSurahName,
    int? lastPlayedSurahNumber,
    int? lastPlayedAyahNumber,
  }) {
    return QuranState(
      status: status ?? this.status,
      error: error ?? this.error,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      surahs: surahs ?? this.surahs,
      lastPlayedSurahName: lastPlayedSurahName ?? this.lastPlayedSurahName,
      lastPlayedSurahNumber:
          lastPlayedSurahNumber ?? this.lastPlayedSurahNumber,
      lastPlayedAyahNumber: lastPlayedAyahNumber ?? this.lastPlayedAyahNumber,
    );
  }

  @override
  List<Object?> get props => [
    status,
    error,
    selectedIndex,
    surahs,
    lastPlayedSurahName,
    lastPlayedSurahNumber,
    lastPlayedAyahNumber,
  ];
}
