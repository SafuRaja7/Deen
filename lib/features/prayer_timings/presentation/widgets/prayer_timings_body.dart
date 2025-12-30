part of '../prayer_timings_screen.dart';

class PrayerTimingsBody extends StatelessWidget {
  final PrayerTimings? timings;
  const PrayerTimingsBody({super.key, this.timings});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimingsBloc, PrayerTimingsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(
                    image: StaticAssets.prayingPerson,
                    title: 'Prayer Timings',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Image.asset(StaticAssets.sunny, height: 40),
                          Text('Sunrise', style: AppText.b2),
                          Text(
                            AppUtils.convertTo12Hour(
                              timings?.timings['Sunrise'] ?? '--:--',
                            ),
                            style: AppText.b2,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AddressCard(address: state.address),
                          Text("", style: AppText.b2),
                          Text("Zawal Time", style: AppText.b2),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(StaticAssets.sunny, height: 40),
                          Text('Sunset', style: AppText.b2),
                          Text(
                            AppUtils.convertTo12Hour(
                              timings?.timings['Sunset'] ?? '--:--',
                            ),
                            style: AppText.b2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (timings?.hijri != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: 15.radius(),
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
                                DateFormat("MMMM yyyy").format(
                                  DateTime(
                                    state.selectedYear,
                                    state.selectedMonth,
                                  ),
                                ),
                                style: AppText.b2,
                              ),
                              Text(
                                '${timings!.hijri.day} ${timings!.hijri.month}, ${timings!.hijri.year}',
                                style: AppText.b2,
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
                          color: AppColors.white,
                          borderRadius: 15.radius(),
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
                                color: AppColors.primary.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                AppUtils.getIconForPrayer(name),
                                color: AppColors.primary,
                                height: 25,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Text(name, style: AppText.b2),
                            const Spacer(),
                            Text(
                              AppUtils.convertTo12Hour(time),
                              style: AppText.b2,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Prayer Times in ${state.address.split(',').first} for ${DateFormat("MMMM yyyy").format(DateTime(state.selectedYear, state.selectedMonth))}",
                    style: AppText.b2,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: 15.radius(),
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
                        if (state.status == PrayerTimingsStatus.loading)
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
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
                                    onPressed: () =>
                                        context.read<PrayerTimingsBloc>().add(
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
                              height: 1,
                              indent: 10,
                              endIndent: 10,
                            ),
                            itemBuilder: (context, index) {
                              final dayTimings = state.monthlyTimings[index];
                              final dayNum = (index + 1).toString().padLeft(
                                2,
                                '0',
                              );
                              final date = DateTime(
                                state.selectedYear,
                                state.selectedMonth,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
      },
    );
  }

  Widget _buildHeaderCell(String label, double width) {
    return SizedBox(
      width: width,
      child: Text(label, textAlign: TextAlign.center, style: AppText.b2),
    );
  }

  Widget _buildDataCell(String value, double width) {
    return SizedBox(
      width: width,
      child: Text(value, textAlign: TextAlign.center, style: AppText.b2),
    );
  }
}
