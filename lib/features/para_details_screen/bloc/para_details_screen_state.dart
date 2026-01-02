import 'package:equatable/equatable.dart';
import 'package:deen/core/models/ayah.dart';

enum ParaDetailsScreenStatus { initial, loading, success, failure }

class ParaDetailsScreenState extends Equatable {
  final ParaDetailsScreenStatus status;
  final List<AyahDetail> ayahs;
  final String? error;

  const ParaDetailsScreenState({
    this.status = ParaDetailsScreenStatus.initial,
    this.ayahs = const [],
    this.error,
  });

  ParaDetailsScreenState copyWith({
    ParaDetailsScreenStatus? status,
    List<AyahDetail>? ayahs,
    String? error,
  }) {
    return ParaDetailsScreenState(
      status: status ?? this.status,
      ayahs: ayahs ?? this.ayahs,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, ayahs, error];
}
