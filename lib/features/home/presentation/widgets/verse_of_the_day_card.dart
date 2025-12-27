part of '../home_screen.dart';

class VerseOfTheDayCard extends StatelessWidget {
  const VerseOfTheDayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading && state.verseOfTheDay == null) {
          return const CardSkeleton(height: 180);
        }

        if (state.error != null && state.verseOfTheDay == null) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 10),
                Text('Failed to load verse', style: AppText.b2),
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

        final verse = state.verseOfTheDay;
        if (verse == null) {
          return const SizedBox.shrink();
        }

        return IntrinsicHeight(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(StaticAssets.frame, fit: BoxFit.fill),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(verse.surah.englishName, style: AppText.b2),
                        Text(
                          '${verse.surah.number}:${verse.numberInSurah}',
                          style: AppText.b2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      verse.arabicText,
                      textAlign: TextAlign.right,
                      style: AppText.b2,
                    ),
                    const SizedBox(height: 15),
                    Image.asset(StaticAssets.dividerFrame),
                    const SizedBox(height: 15),
                    Text(verse.englishTranslation, style: AppText.b2),
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
