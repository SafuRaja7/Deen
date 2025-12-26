import 'package:deen/core/theme/app_colors.dart';
import 'package:deen/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class PrayerTimingsPage extends StatelessWidget {
  const PrayerTimingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      appBar: AppBar(
        title: const Text('Prayer Timings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.textDark,
      ),
      body: Center(
        child: Text('Prayer Timings Screen', style: AppTextStyles.headingBold),
      ),
    );
  }
}
