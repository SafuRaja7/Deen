part of '../home_screen.dart';

class ReflectionOfPeaceCard extends StatelessWidget {
  const ReflectionOfPeaceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading &&
            state.reflectionOfTheDay == null) {
          return const CardSkeleton(height: 150);
        }

        if (state.error != null && state.reflectionOfTheDay == null) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: AppProps.card,
            child: Column(
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 10),
                Text('Failed to load reflection', style: AppText.b2),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () => context.read<HomeBloc>().add(LoadHomeData()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final reflection = state.reflectionOfTheDay;
        if (reflection == null) {
          return const SizedBox.shrink();
        }

        return IntrinsicHeight(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(StaticAssets.frame, fit: BoxFit.fill),
              ),
              Container(
                margin: Space.a.t20,
                padding: Space.a.t25,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: 10.radius(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          reflection.surah.englishName,
                          style: AppText.b3 + FontWeight.bold,
                        ),
                        Text(
                          '${reflection.surah.number}:${reflection.numberInSurah}',
                          style: AppText.b3 + FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      reflection.arabicText,
                      textAlign: TextAlign.right,
                      style: AppText.h2 + FontWeight.bold,
                    ),
                    const SizedBox(height: 15),
                    Image.asset(StaticAssets.dividerFrame),
                    const SizedBox(height: 15),
                    Text(
                      reflection.englishTranslation.capitalize,
                      style: AppText.b1 + FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
