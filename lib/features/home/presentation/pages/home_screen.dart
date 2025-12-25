import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 24),
              _buildPrayerCard(),
              const SizedBox(height: 24),
              _buildQuickActions(),
              const SizedBox(height: 24),
              _buildContinueReading(),
              const SizedBox(height: 24),
              _buildVerseOfDay(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 16,
                  color: AppColors.primaryGold,
                ),
                const SizedBox(width: 4),
                Text("Dhaka, Bangladesh", style: AppTextStyles.bodySmall),
              ],
            ),
            const SizedBox(height: 4),
            Text("3 Dhul-Hijjah, 1446", style: AppTextStyles.headingMedium),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _buildPrayerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBlue,
        borderRadius: BorderRadius.circular(24),
        gradient: AppColors.prayerCardGradient,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Isha",
                style: AppTextStyles.bodyNormal.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Text(
                "08:15 PM",
                style: AppTextStyles.headingBold.copyWith(
                  color: Colors.white,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Starts in 2 Minutes",
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.accentGold,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.2,
              child: Icon(Icons.dark_mode, size: 80, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'name': 'Qibla', 'icon': Icons.explore_outlined},
      {'name': 'Quran', 'icon': Icons.menu_book_outlined},
      {'name': 'Dua', 'icon': Icons.volunteer_activism_outlined},
      {'name': 'Prayer', 'icon': Icons.access_time_outlined},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                actions[index]['icon'] as IconData,
                color: AppColors.primaryGold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              actions[index]['name'] as String,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textDark,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContinueReading() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.auto_stories, color: AppColors.primaryGold),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Last Read", style: AppTextStyles.bodySmall),
                Text(
                  "Surah Al-Baqarah 117",
                  style: AppTextStyles.headingMedium.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textLight),
        ],
      ),
    );
  }

  Widget _buildVerseOfDay() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryGold.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryGold.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            "بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيْمِ",
            style: AppTextStyles.arabicText.copyWith(
              fontSize: 20,
              color: AppColors.primaryGold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Verily, with every hardship comes ease.",
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyNormal.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text("Surah Ash-Sharh [94:5]", style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}
