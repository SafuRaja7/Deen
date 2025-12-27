part of '../home_screen.dart';

class QuranTrackCard extends StatelessWidget {
  const QuranTrackCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.only(top: 15, left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Continue Reading Qur'an", style: AppText.b2),
              Text("Surah' Al Bakarah 117", style: AppText.b2),
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Tap to Continue", style: AppText.b2),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primary,
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
          Image.asset(StaticAssets.quranRehal, height: 100),
        ],
      ),
    );
  }
}
