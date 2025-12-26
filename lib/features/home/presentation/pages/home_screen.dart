import 'dart:ui';
import 'package:deen/core/constants/prayer_time.dart';
import 'package:deen/core/models/prayer_timings.dart';
import 'package:deen/core/theme/app_colors.dart';
import 'package:deen/core/theme/app_text_styles.dart';
import 'package:deen/core/utils/app_utils.dart';
import 'package:deen/core/utils/static_assets.dart';
import 'package:deen/core/providers/app_provider.dart';
import 'package:deen/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deen/features/prayer_timings/presentation/pages/prayer_timings.dart';

part '../widgets/time_container.dart';
part '../widgets/view_prayer_timings_card.dart';
part '../widgets/top_card.dart';
part '../widgets/quran_track_card.dart';
part '../widgets/home_features_row.dart';
part '../widgets/verse_of_the_day_card.dart';
part '../widgets/reflection_of_peace_card.dart';
part '../widgets/faith_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopCard(),
            QuranTrackCard(),
            const SizedBox(height: 10),
            const HomeFeaturesRow(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "Verse of the Day",
                    style: AppTextStyles.bodyNormal.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const VerseOfTheDayCard(),
                  const SizedBox(height: 20),
                  Text(
                    "Reflection of Peace",
                    style: AppTextStyles.bodyNormal.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const ReflectionOfPeaceCard(),
                  const SizedBox(height: 20),
                  Text(
                    "Revive Your Faith",
                    style: AppTextStyles.bodyNormal.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...AppUtils.list.asMap().entries.map((e) {
                    return FaithCard(
                      e.value["image"],
                      e.value["title"],
                      e.value["desc"],
                      () {},
                    );
                  }),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
