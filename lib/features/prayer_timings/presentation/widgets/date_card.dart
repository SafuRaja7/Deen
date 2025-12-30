part of '../prayer_timings_screen.dart';

class DateCard extends StatelessWidget {
  final PrayerTimingsState state;
  final PrayerTimings? timings;
  const DateCard({super.key, required this.state, this.timings});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Space.a.t25,
      decoration: AppProps.card,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.read<PrayerTimingsBloc>().add(
              const ChangeTimingsMonth(-1),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat(
                  "MMMM yyyy",
                ).format(DateTime(state.selectedYear, state.selectedMonth)),
                style: AppText.b1 + FontWeight.bold,
              ),
              Text(
                '${timings!.hijri.day} ${timings!.hijri.month}, ${timings!.hijri.year}',
                style: AppText.b2 + AppColors.textSub + FontWeight.w600,
              ),
            ],
          ),
          GestureDetector(
            onTap: () => context.read<PrayerTimingsBloc>().add(
              const ChangeTimingsMonth(1),
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
