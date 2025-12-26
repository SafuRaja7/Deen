import 'dart:ui';
import 'package:deen/core/theme/app_text_styles.dart';
import 'package:deen/core/utils/statis_assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/prayer_time.dart';
import '../providers/prayer_provider.dart';

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
                        Colors.black.withOpacity(0.55),
                        Colors.black.withOpacity(0.55),
                        Colors.black.withOpacity(0.55),
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
                  top: 80,
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
                  top: 220,
                  child: Text(
                    prayerProvider.currentPrayer,
                    style: AppTextStyles.headingBold.copyWith(
                      color: AppColors.pureWhite,
                    ),
                  ),
                ),
                Positioned(
                  top: 260,
                  child: Text(
                    currentTimeStr,
                    style: AppTextStyles.headingBold.copyWith(
                      color: AppColors.pureWhite,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 180,
                  child: Text(
                    timeLeftStr,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.pureWhite,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 140,
                  child: Container(
                    padding:
                        const EdgeInsets.all(5) +
                        const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.textGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50),
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
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.pureWhite.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.pureWhite.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha']
                              .asMap()
                              .entries
                              .expand((entry) {
                                final key = entry.value;
                                final isLast = entry.key == 4;
                                final time = timings?.timings[key] ?? "--:--";
                                final prayerEnum = PrayerTime.fromString(key);

                                return [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image(
                                        image: AssetImage(prayerEnum.img),
                                        height: 26,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        prayerEnum.displayName,
                                        style: AppTextStyles.bodyNormal
                                            .copyWith(
                                              color: AppColors.pureWhite,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                      ),
                                      Text(
                                        time,
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: AppColors.pureWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (!isLast)
                                    Container(
                                      height: 20,
                                      width: 2,
                                      decoration: BoxDecoration(
                                        color: AppColors.pureWhite.withValues(
                                          alpha: 0.5,
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                ];
                              })
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
