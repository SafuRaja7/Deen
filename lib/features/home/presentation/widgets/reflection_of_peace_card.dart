part of '../pages/home_screen.dart';

class ReflectionOfPeaceCard extends StatelessWidget {
  const ReflectionOfPeaceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();

    if (appProvider.isReflectionLoading) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.primaryGold),
        ),
      );
    }

    if (appProvider.reflectionError != null) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
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
            Text(
              'Failed to load reflection',
              style: AppTextStyles.bodyNormal.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              appProvider.reflectionError ?? 'Unknown error',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textGrey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => appProvider.fetchReflectionOfTheDay(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGold,
                foregroundColor: AppColors.pureWhite,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final reflection = appProvider.reflectionOfTheDay;
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
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reflection.surah.englishName,
                      style: AppTextStyles.bodyNormal.copyWith(
                        color: AppColors.primaryGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${reflection.surah.number}:${reflection.numberInSurah}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  reflection.arabicText,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.arabicText.copyWith(
                    color: AppColors.textDark,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(StaticAssets.dividerFrame),
                const SizedBox(height: 15),
                Text(
                  reflection.englishTranslation,
                  style: AppTextStyles.bodyNormal.copyWith(
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
