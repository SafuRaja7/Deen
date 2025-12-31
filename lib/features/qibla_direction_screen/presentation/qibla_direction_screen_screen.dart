import 'package:deen/features/qibla_direction_screen/data/qibla_direction_repository.dart';
import 'package:deen/features/qibla_direction_screen/presentation/widgets/qibla_direction_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/qibla_direction_screen_bloc.dart';
import '../bloc/qibla_direction_screen_event.dart';
import '../bloc/qibla_direction_screen_state.dart';

class QiblaDirectionScreen extends StatelessWidget {
  const QiblaDirectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          QiblaDirectionScreenBloc(repository: QiblaDirectionRepository())..add(
            const LoadQiblaDirectionScreenData(
              latitude: 23.8103,
              longitude: 90.4125,
            ),
          ),
      child: Scaffold(
        body: BlocBuilder<QiblaDirectionScreenBloc, QiblaDirectionScreenState>(
          builder: (context, state) {
            if (state.status == QiblaDirectionScreenStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == QiblaDirectionScreenStatus.failure) {
              return Center(child: Text(state.error ?? 'Error'));
            }

            if (state.status == QiblaDirectionScreenStatus.success) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Qibla Direction: ${state.qiblaDirection!.toStringAsFixed(1)}°',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 24),
                  QiblaDirectionScreenBody(
                    qiblaDirection: state.qiblaDirection!,
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
