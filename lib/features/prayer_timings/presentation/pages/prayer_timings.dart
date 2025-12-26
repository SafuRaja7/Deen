import 'package:deen/core/models/prayer_timings.dart';
import 'package:deen/core/providers/app_provider.dart';
import 'package:deen/core/theme/app_colors.dart';
import 'package:deen/core/theme/app_text_styles.dart';
import 'package:deen/core/utils/app_utils.dart';
import 'package:deen/core/utils/static_assets.dart';
import 'package:deen/widgets/address_card.dart';
import 'package:deen/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrayerTimingsPage extends StatelessWidget {
  final PrayerTimings? timings;
  const PrayerTimingsPage({super.key, this.timings});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TopBar(
                image: StaticAssets.prayingPerson,
                title: 'Prayer Timings',
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: .start,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset(StaticAssets.sunny, height: 40),
                      Text(
                        'Sunrise',
                        style: AppTextStyles.bodyNormal.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppUtils.convertTo12Hour(
                          timings?.timings['Sunrise'] ?? '--:--',
                        ),
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      AddressCard(),
                      Text(
                        "",
                        style: AppTextStyles.bodyNormal.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Zawal Time",
                        style: AppTextStyles.bodyNormal.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(StaticAssets.sunny, height: 40),
                      Text(
                        'Sunset',
                        style: AppTextStyles.bodyNormal.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AppUtils.convertTo12Hour(
                          timings?.timings['Sunset'] ?? '--:--',
                        ),
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (timings?.hijri != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primaryGold,
                        size: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppUtils.getFormattedDate(),
                            style: AppTextStyles.bodyNormal.copyWith(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${timings!.hijri.day} ${timings!.hijri.month}, ${timings!.hijri.year}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textDark,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primaryGold,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppUtils.prayerNames.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final name = AppUtils.prayerNames[index];
                  final time = timings?.timings[name] ?? '--:--';

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGold.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            AppUtils.getIconForPrayer(name),
                            color: AppColors.primaryGold,
                            height: 25,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          name,
                          style: AppTextStyles.bodyNormal.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          AppUtils.convertTo12Hour(time),
                          style: AppTextStyles.bodyNormal.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
