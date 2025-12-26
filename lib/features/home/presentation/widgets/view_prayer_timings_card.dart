part of '../pages/home_screen.dart';

class ViewPrayerTimingsCard extends StatelessWidget {
  const ViewPrayerTimingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: AppColors.pureWhite.withValues(alpha: 0.1),
          ),
          child: Row(
            children: [
              Image(image: AssetImage(StaticAssets.prayingPerson), height: 30),
              SizedBox(width: 10),
              Text(
                'View All Prayer Timings',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.pureWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.pureWhite,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
