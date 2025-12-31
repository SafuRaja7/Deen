import 'package:equatable/equatable.dart';

abstract class QiblaDirectionScreenEvent extends Equatable {
  const QiblaDirectionScreenEvent();

  @override
  List<Object?> get props => [];
}

class LoadQiblaDirectionScreenData extends QiblaDirectionScreenEvent {
  final double latitude;
  final double longitude;

  const LoadQiblaDirectionScreenData({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}
