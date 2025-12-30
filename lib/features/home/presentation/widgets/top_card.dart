part of '../home_screen.dart';

class TopCard extends StatelessWidget {
  const TopCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final currentPrayerEnum = PrayerTime.fromString(state.currentPrayer);

        if (state.status == HomeStatus.failure && state.timings == null) {
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.55,
            width: double.infinity,
            color: AppColors.background,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Error: ${state.error}", textAlign: TextAlign.center),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<HomeBloc>().add(LoadHomeData()),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),
          );
        }

        final timings = state.timings;
        final hijri = timings?.hijri;
        final currentTimeStr = timings?.timings[state.currentPrayer] ?? "--:--";

        // Format duration for "Ends in X Minutes / Hours"
        String timeLeftStr = "";
        if (state.timeLeft.inHours > 0) {
          timeLeftStr =
              "${state.timeLeft.inHours}h ${state.timeLeft.inMinutes % 60}m";
        } else if (state.timeLeft.inMinutes > 0) {
          timeLeftStr = "${state.timeLeft.inMinutes} Minutes";
        } else {
          timeLeftStr = "${state.timeLeft.inSeconds} Seconds";
        }

        return Container(
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
                    color: AppColors.primary,
                    borderRadius: 50.radius(),
                  ),
                  child: Center(
                    child: Text(
                      hijri != null
                          ? '${hijri.day} ${hijri.month}, ${hijri.year}'
                          : '...',
                      style: AppText.b3 + AppColors.white,
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
                  state.currentPrayer,
                  style: AppText.h1 + AppColors.white + FontWeight.bold,
                ),
              ),
              Positioned(
                top: 240,
                child: Text(
                  AppUtils.convertTo12Hour(currentTimeStr),
                  style: AppText.h1 + AppColors.white,
                ),
              ),
              Positioned(
                top: 290,
                child: Text.rich(
                  TextSpan(
                    text: 'Ends in ',
                    style: AppText.b2 + AppColors.white,
                    children: [
                      TextSpan(
                        text: timeLeftStr,
                        style: AppText.b2 + AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(top: 320, child: AddressCard(address: state.address)),
              Positioned(
                top: 360,
                left: 20,
                right: 20,
                child: TimeContainer(timings: timings),
              ),
              const ViewPrayerTimingsCard(),
            ],
          ),
        );
      },
    );
  }
}
