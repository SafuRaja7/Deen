import 'dart:ui';
import 'package:deen/core/constants/prayer_time.dart';
import 'package:deen/core/models/prayer_timings.dart';
import 'package:deen/core/theme/app_colors.dart';
import 'package:deen/core/theme/app_text_styles.dart';
import 'package:deen/core/utils/statis_assets.dart';
import 'package:deen/features/home/presentation/providers/prayer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part '../widgets/time_container.dart';
part '../widgets/view_prayer_timings_card.dart';
part '../widgets/top_card.dart';
part '../widgets/quran_track_card.dart';
part '../widgets/home_features_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      body: Column(
        crossAxisAlignment: .start,
        children: [
          TopCard(),
          QuranTrackCard(),
          const SizedBox(height: 10),
          const HomeFeaturesRow(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Verse of the Day",
              style: AppTextStyles.bodyNormal.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
