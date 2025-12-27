import 'package:deen/core/models/surah.dart';
import 'package:equatable/equatable.dart';

enum QuranStatus { initial, loading, success, failure }

class QuranState extends Equatable {
  final QuranStatus status;
  final String? error;
  final int selectedIndex;
  final List<Surah> surahs;

  const QuranState({
    this.status = QuranStatus.initial,
    this.error,
    this.selectedIndex = 0,
    this.surahs = const [],
  });

  QuranState copyWith({
    QuranStatus? status,
    String? error,
    int? selectedIndex,
    List<Surah>? surahs,
  }) {
    return QuranState(
      status: status ?? this.status,
      error: error ?? this.error,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      surahs: surahs ?? this.surahs,
    );
  }

  @override
  List<Object?> get props => [status, error, selectedIndex, surahs];
}
