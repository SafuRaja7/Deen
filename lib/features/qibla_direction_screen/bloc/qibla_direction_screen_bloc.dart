import 'package:deen/features/qibla_direction_screen/data/qibla_direction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'qibla_direction_screen_event.dart';
import 'qibla_direction_screen_state.dart';

class QiblaDirectionScreenBloc
    extends Bloc<QiblaDirectionScreenEvent, QiblaDirectionScreenState> {
  final QiblaDirectionRepository repository;

  QiblaDirectionScreenBloc({required this.repository})
    : super(const QiblaDirectionScreenState()) {
    on<LoadQiblaDirectionScreenData>(_onLoad);
  }

  Future<void> _onLoad(
    LoadQiblaDirectionScreenData event,
    Emitter<QiblaDirectionScreenState> emit,
  ) async {
    emit(state.copyWith(status: QiblaDirectionScreenStatus.loading));

    try {
      final direction = await repository.fetchQiblaDirection(
        latitude: event.latitude,
        longitude: event.longitude,
      );

      emit(
        state.copyWith(
          status: QiblaDirectionScreenStatus.success,
          qiblaDirection: direction,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: QiblaDirectionScreenStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
