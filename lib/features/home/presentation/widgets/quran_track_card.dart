part of '../home_screen.dart';

class QuranTrackCard extends StatelessWidget {
  const QuranTrackCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Space.a.t25,
      padding: Space.only(10, 0, 0, 10),
      decoration: AppProps.card,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: .start,
            children: [
              Text(
                "Continue Reading Qur'an",
                style: AppText.b1 + AppColors.black + FontWeight.w600,
              ),
              Text(
                "Surah' Al Bakarah 117",
                style: AppText.b2 + AppColors.black,
              ),
              Space.y.t10,
              Row(
                children: [
                  Text(
                    "Tap to Continue",
                    style: AppText.b3 + AppColors.primary + FontWeight.w600,
                  ),
                  Space.x.t20,
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primary,
                    size: 6.un(),
                  ),
                ],
              ),
            ],
          ),
          Image.asset(StaticAssets.quranRehal, height: 40.un()),
        ],
      ),
    );
  }
}
