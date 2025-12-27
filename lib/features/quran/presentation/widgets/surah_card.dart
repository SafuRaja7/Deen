part of '../quran_screen.dart';

class SurahCard extends StatelessWidget {
  final Surah surah;
  const SurahCard({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.surahDetails,
          arguments: surah.number,
        );
      },
      child: Container(
        padding: Space.a.t20,
        decoration: AppProps.card,
        child: Row(
          children: [
            Container(
              padding: Space.a.t20,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  surah.number.toString(),
                  style: AppText.b3.copyWith(color: AppColors.black),
                ),
              ),
            ),
            Space.x.t20,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  surah.englishName,
                  style: AppText.b1.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  surah.englishNameTranslation,
                  style: AppText.b2.copyWith(
                    color: AppColors.textSub,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              surah.name,
              style: AppText.b1.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
