import 'package:equatable/equatable.dart';

enum SurahStatus { initial, loading, success, failure }

class SurahState extends Equatable {
  final SurahStatus status;
  final String? error;

  const SurahState({
    this.status = SurahStatus.initial,
    this.error,
  });

  SurahState copyWith({
    SurahStatus? status,
    String? error,
  }) {
    return SurahState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
