part of '../prayer_timings_screen.dart';

class PrayerTimesMonthCard extends StatelessWidget {
  final PrayerTimingsState state;
  const PrayerTimesMonthCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppProps.card,
      child: Column(
        children: [
          Padding(
            padding: Space.a.t20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    children: [
                      Image.asset(StaticAssets.calendar, height: 10.un()),
                      Space.y.t10,
                      Text(
                        "Day",
                        textAlign: TextAlign.center,
                        style: AppText.b3 + FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                ...AppUtils.prayerNames.map(
                  (name) => FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      children: [
                        Image.asset(
                          AppUtils.getIconForPrayer(name),
                          height: 10.un(),
                        ),
                        Space.y.t10,
                        Text(
                          name,
                          textAlign: TextAlign.center,
                          style: AppText.b3 + FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (state.status == PrayerTimingsStatus.loading)
            Padding(
              padding: Space.a.t20,
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            )
          else if (state.status == PrayerTimingsStatus.failure)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    Text("Error: ${state.error}"),
                    ElevatedButton(
                      onPressed: () => context.read<PrayerTimingsBloc>().add(
                        LoadMonthlyTimings(
                          address: state.address,
                          month: state.selectedMonth,
                          year: state.selectedYear,
                        ),
                      ),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.monthlyTimings.length,
              separatorBuilder: (context, index) => const Divider(
                height: 0,
                indent: 10,
                endIndent: 10,
                color: AppColors.white,
              ),
              itemBuilder: (context, index) {
                final dayTimings = state.monthlyTimings[index];
                final dayNum = (index + 1).toString().padLeft(2, '0');
                final date = DateTime(
                  state.selectedYear,
                  state.selectedMonth,
                  index + 1,
                );
                final dayName = DateFormat('E').format(date).substring(0, 2);

                final now = DateTime.now();
                final isToday =
                    date.day == now.day &&
                    date.month == now.month &&
                    date.year == now.year;

                final textColor = isToday ? AppColors.primary : AppColors.black;

                return Padding(
                  padding: Space.a.t20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "$dayNum, $dayName",
                          textAlign: TextAlign.center,
                          style: AppText.s1 + textColor,
                        ),
                      ),
                      ...dayTimings.timings.entries
                          .where(
                            (entry) =>
                                entry.key != 'Sunrise' &&
                                entry.key != 'Sunset' &&
                                entry.key != 'Imsak' &&
                                entry.key != 'Midnight' &&
                                entry.key != 'Firstthird' &&
                                entry.key != 'Lastthird',
                          )
                          .map(
                            (entry) => FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                AppUtils.convertTo12Hour(entry.value),
                                textAlign: TextAlign.center,
                                style: AppText.s1 + textColor,
                              ),
                            ),
                          ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
