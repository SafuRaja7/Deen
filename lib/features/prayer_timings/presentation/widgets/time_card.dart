part of '../prayer_timings_screen.dart';

class TimeCard extends StatelessWidget {
  final String name;
  final String time;
  const TimeCard({super.key, required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Space.a.t20,
      decoration: AppProps.card,
      child: Row(
        children: [
          Container(
            padding: Space.a.t10,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              AppUtils.getIconForPrayer(name),
              color: AppColors.primary,
              height: 25,
            ),
          ),
          Space.x.t20,
          Text(name, style: AppText.b2 + FontWeight.bold),
          const Spacer(),
          Text(AppUtils.convertTo12Hour(time), style: AppText.b2),
        ],
      ),
    );
  }
}
