import 'package:deen/core/models/prayer_timings.dart';
import 'package:deen/core/providers/app_provider.dart';
import 'package:deen/core/theme/app_colors.dart';
import 'package:deen/core/theme/app_text_styles.dart';
import 'package:deen/core/utils/app_utils.dart';
import 'package:deen/core/utils/static_assets.dart';
import 'package:deen/widgets/address_card.dart';
import 'package:deen/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
            crossAxisAlignment: .start,
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
                      GestureDetector(
                        onTap: () => appProvider.changeMonth(-1),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.primaryGold,
                          size: 20,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat("MMMM yyyy").format(
                              DateTime(
                                appProvider.selectedYear,
                                appProvider.selectedMonth,
                              ),
                            ),
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
                      GestureDetector(
                        onTap: () => appProvider.changeMonth(1),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primaryGold,
                          size: 20,
                        ),
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
              const SizedBox(height: 20),
              Text(
                "Prayer Times in ${appProvider.address.split(',').first} for ${DateFormat("MMMM yyyy").format(DateTime(appProvider.selectedYear, appProvider.selectedMonth))}",
                style: AppTextStyles.bodyNormal.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Table Header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHeaderCell("Day", 50),
                          _buildHeaderCell("Fajr", 55),
                          _buildHeaderCell("Dhuhr", 55),
                          _buildHeaderCell("Asr", 55),
                          _buildHeaderCell("Maghrib", 65),
                          _buildHeaderCell("Isha", 55),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    if (appProvider.isMonthlyLoading)
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryGold,
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: appProvider.monthlyTimings.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1, indent: 10, endIndent: 10),
                        itemBuilder: (context, index) {
                          final dayTimings = appProvider.monthlyTimings[index];
                          final dayNum = (index + 1).toString().padLeft(2, '0');
                          final date = DateTime(
                            appProvider.selectedYear,
                            appProvider.selectedMonth,
                            index + 1,
                          );
                          final dayName = DateFormat(
                            'E',
                          ).format(date).substring(0, 2);

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildDataCell("$dayNum, $dayName", 50),
                                _buildDataCell(
                                  AppUtils.convertTo12Hour(
                                    dayTimings.timings['Fajr'] ?? '',
                                  ),
                                  55,
                                ),
                                _buildDataCell(
                                  AppUtils.convertTo12Hour(
                                    dayTimings.timings['Dhuhr'] ?? '',
                                  ),
                                  55,
                                ),
                                _buildDataCell(
                                  AppUtils.convertTo12Hour(
                                    dayTimings.timings['Asr'] ?? '',
                                  ),
                                  55,
                                ),
                                _buildDataCell(
                                  AppUtils.convertTo12Hour(
                                    dayTimings.timings['Maghrib'] ?? '',
                                  ),
                                  65,
                                ),
                                _buildDataCell(
                                  AppUtils.convertTo12Hour(
                                    dayTimings.timings['Isha'] ?? '',
                                  ),
                                  55,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String label, double width) {
    return SizedBox(
      width: width,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildDataCell(String value, double width) {
    return SizedBox(
      width: width,
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodySmall.copyWith(
          fontSize: 10,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}
