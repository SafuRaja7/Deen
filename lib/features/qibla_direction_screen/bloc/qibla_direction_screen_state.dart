import 'package:equatable/equatable.dart';

enum QiblaDirectionScreenStatus { initial, loading, success, failure }

class QiblaDirectionScreenState extends Equatable {
  final QiblaDirectionScreenStatus status;
  final double? qiblaDirection;
  final String? error;

  const QiblaDirectionScreenState({
    this.status = QiblaDirectionScreenStatus.initial,
    this.qiblaDirection,
    this.error,
  });

  QiblaDirectionScreenState copyWith({
    QiblaDirectionScreenStatus? status,
    double? qiblaDirection,
    String? error,
  }) {
    return QiblaDirectionScreenState(
      status: status ?? this.status,
      qiblaDirection: qiblaDirection ?? this.qiblaDirection,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, qiblaDirection, error];
}
