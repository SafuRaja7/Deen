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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prayerProvider = context.watch<PrayerProvider>();
    final currentPrayerEnum = PrayerTime.fromString(
      prayerProvider.currentPrayer,
    );

    if (prayerProvider.error != null && prayerProvider.timings == null) {
      return Scaffold(
        backgroundColor: AppColors.backgroundBeige,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Error: ${prayerProvider.error}",
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () => prayerProvider.fetchTimings(),
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }

    final timings = prayerProvider.timings;
    final hijri = timings?.hijri;
    final currentTimeStr =
        timings?.timings[prayerProvider.currentPrayer] ?? "--:--";

    // Format duration for "Ends in X Minutes / Hours"
    String timeLeftStr = "";
    if (prayerProvider.timeLeft.inHours > 0) {
      timeLeftStr =
          "Ends in ${prayerProvider.timeLeft.inHours}h ${prayerProvider.timeLeft.inMinutes % 60}m";
    } else {
      timeLeftStr = "Ends in ${prayerProvider.timeLeft.inMinutes} Minutes";
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      body: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.55,
            width: double.infinity,
            decoration: BoxDecoration(gradient: currentPrayerEnum.gradient),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * 0.55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.55),
                        Colors.black.withValues(alpha: 0.55),
                        Colors.black.withValues(alpha: 0.55),
                      ],
                    ),
                  ),
                ),
                const Image(image: AssetImage(StaticAssets.mosque)),
                const Positioned(
                  top: 70,
                  left: 40,
                  child: Image(
                    image: AssetImage(StaticAssets.leftLattern),
                    height: 60,
                  ),
                ),
                const Positioned(
                  top: 70,
                  right: 40,
                  child: Image(
                    image: AssetImage(StaticAssets.rightLattern),
                    height: 50,
                  ),
                ),
                const Positioned(
                  top: 115,
                  right: 42,
                  child: Image(
                    image: AssetImage(StaticAssets.rightLattern),
                    height: 50,
                  ),
                ),
                const Positioned(
                  top: 115,
                  right: 100,
                  left: 50,
                  child: Image(
                    image: AssetImage(StaticAssets.halfMoon),
                    height: 100,
                  ),
                ),
                const Positioned(
                  top: 130,
                  right: 90,
                  left: 40,
                  child: Image(
                    image: AssetImage(StaticAssets.centerLattern),
                    height: 40,
                  ),
                ),
                const Positioned(
                  top: 130,

                  child: Image(
                    image: AssetImage(StaticAssets.stars),
                    height: 120,
                  ),
                ),
                Positioned(
                  top: 75,
                  child: Container(
                    padding:
                        const EdgeInsets.all(5) +
                        const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        hijri != null
                            ? '${hijri.day} ${hijri.month}, ${hijri.year}'
                            : '...',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 130,
                  child: Image(
                    image: AssetImage(currentPrayerEnum.img),
                    height: 70,
                  ),
                ),
                Positioned(
                  top: 200,
                  child: Text(
                    prayerProvider.currentPrayer,
                    style: AppTextStyles.headingBold.copyWith(
                      color: AppColors.pureWhite,
                    ),
                  ),
                ),
                Positioned(
                  top: 240,
                  child: Text(
                    currentTimeStr,
                    style: AppTextStyles.headingBold.copyWith(
                      color: AppColors.pureWhite,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 200,
                  child: Text(
                    timeLeftStr,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.pureWhite,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        padding:
                            const EdgeInsets.all(5) +
                            const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: AppColors.textGrey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: AppColors.pureWhite.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.pin_drop_outlined,
                              color: AppColors.pureWhite,
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              prayerProvider.address,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.pureWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60,
                  left: 20,
                  right: 20,
                  child: TimeContainer(timings: timings),
                ),
                ViewPrayerTimingsCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
