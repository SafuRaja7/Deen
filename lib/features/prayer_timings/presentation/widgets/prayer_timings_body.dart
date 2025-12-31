part of '../prayer_timings_screen.dart';

class PrayerTimingsBody extends StatelessWidget {
  final PrayerTimings? timings;
  const PrayerTimingsBody({super.key, this.timings});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return BlocBuilder<PrayerTimingsBloc, PrayerTimingsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(
                image: StaticAssets.prayingPerson,
                title: 'Prayer Timings',
              ),
              Space.y.t30,
              Padding(
                padding: Space.h.t30,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(StaticAssets.sunny, height: 14.un()),
                            Text(
                              'Sunrise',
                              style: AppText.b2 + FontWeight.w400,
                            ),
                            Text(
                              AppUtils.convertTo12Hour(
                                timings?.timings['Sunrise'] ?? '--:--',
                              ),
                              style: AppText.b3 + FontWeight.w500,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AddressCard(address: state.address),
                            Space.y.t10,
                            Text(
                              "Zawal Time",
                              style: AppText.b2 + FontWeight.w500,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              StaticAssets.maghribSun,
                              height: 15.un(),
                            ),
                            Text('Sunset', style: AppText.b2 + FontWeight.w400),
                            Text(
                              AppUtils.convertTo12Hour(
                                timings?.timings['Sunset'] ?? '--:--',
                              ),
                              style: AppText.b3 + FontWeight.w500,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Space.y.t30,
                    if (timings?.hijri != null)
                      DateCard(state: state, timings: timings),
                    Space.y.t30,
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: AppUtils.prayerNames.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final name = AppUtils.prayerNames[index];
                        final time = timings?.timings[name] ?? '--:--';

                        return TimeCard(name: name, time: time);
                      },
                    ),
                    Space.y.t30,
                    Text(
                      "Prayer Times in ${state.address.split(',').first} for ${DateFormat("MMMM yyyy").format(DateTime(state.selectedYear, state.selectedMonth))}",
                      style: AppText.b2 + FontWeight.bold,
                    ),
                    Space.y.t20,
                    PrayerTimesMonthCard(state: state),
                    Space.y.t30,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
