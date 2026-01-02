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
  final int? lastPlayedGlobalAyahNumber;
  final String? lastReadSurahName;
  final int? lastReadSurahNumber;
  final int? lastReadAyahNumber;

  const QuranState({
    this.status = QuranStatus.initial,
    this.error,
    this.selectedIndex = 0,
    this.surahs = const [],
    this.lastPlayedSurahName,
    this.lastPlayedSurahNumber,
    this.lastPlayedAyahNumber,
    this.lastPlayedGlobalAyahNumber,
    this.lastReadSurahName,
    this.lastReadSurahNumber,
    this.lastReadAyahNumber,
  });

  QuranState copyWith({
    QuranStatus? status,
    String? error,
    int? selectedIndex,
    List<Surah>? surahs,
    String? lastPlayedSurahName,
    int? lastPlayedSurahNumber,
    int? lastPlayedAyahNumber,
    int? lastPlayedGlobalAyahNumber,
    String? lastReadSurahName,
    int? lastReadSurahNumber,
    int? lastReadAyahNumber,
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
      lastPlayedGlobalAyahNumber:
          lastPlayedGlobalAyahNumber ?? this.lastPlayedGlobalAyahNumber,
      lastReadSurahName: lastReadSurahName ?? this.lastReadSurahName,
      lastReadSurahNumber: lastReadSurahNumber ?? this.lastReadSurahNumber,
      lastReadAyahNumber: lastReadAyahNumber ?? this.lastReadAyahNumber,
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
    lastPlayedGlobalAyahNumber,
    lastReadSurahName,
    lastReadSurahNumber,
    lastReadAyahNumber,
  ];
}
