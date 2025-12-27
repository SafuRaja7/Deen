part of '../home_screen.dart';

class TimeContainer extends StatelessWidget {
  final PrayerTimings? timings;
  const TimeContainer({super.key, required this.timings});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.2)),
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
                        Image(image: AssetImage(prayerEnum.img), height: 26),
                        const SizedBox(height: 4),
                        Text(prayerEnum.displayName, style: AppText.b2),
                        Text(AppUtils.convertTo12Hour(time), style: AppText.b2),
                      ],
                    ),
                    if (!isLast)
                      Container(
                        height: 20,
                        width: 2,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                  ];
                })
                .toList(),
          ),
        ),
      ),
    );
  }
}
