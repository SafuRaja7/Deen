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
        color: AppColors.pureWhite,
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
              Text(
                "Continue Reading Qur'an",
                style: AppTextStyles.bodyNormal.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                "Surah' Al Bakarah 117",
                style: AppTextStyles.bodyNormal.copyWith(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Tap to Continue",
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primaryGold,
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
