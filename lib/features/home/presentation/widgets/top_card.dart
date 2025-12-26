part of '../pages/home_screen.dart';

class TopCard extends StatelessWidget {
  const TopCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final currentPrayerEnum = PrayerTime.fromString(appProvider.currentPrayer);

    if (appProvider.prayerError != null && appProvider.timings == null) {
      return Scaffold(
        backgroundColor: AppColors.backgroundBeige,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Error: ${appProvider.prayerError}",
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () => appProvider.fetchPrayerTimings(),
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }

    final timings = appProvider.timings;
    final hijri = timings?.hijri;
    final currentTimeStr =
        timings?.timings[appProvider.currentPrayer] ?? "--:--";

    // Format duration for "Ends in X Minutes / Hours"
    String timeLeftStr = "";
    if (appProvider.timeLeft.inHours > 0) {
      timeLeftStr =
          "Ends in ${appProvider.timeLeft.inHours}h ${appProvider.timeLeft.inMinutes % 60}m";
    } else {
      timeLeftStr = "Ends in ${appProvider.timeLeft.inMinutes} Minutes";
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
            child: Image(image: AssetImage(StaticAssets.halfMoon), height: 100),
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
            child: Image(image: AssetImage(StaticAssets.stars), height: 120),
          ),
          Positioned(
            top: 75,
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
            child: Image(image: AssetImage(currentPrayerEnum.img), height: 70),
          ),
          Positioned(
            top: 200,
            child: Text(
              appProvider.currentPrayer,
              style: AppTextStyles.headingBold.copyWith(
                color: AppColors.pureWhite,
              ),
            ),
          ),
          Positioned(
            top: 240,
            child: Text(
              AppUtils.convertTo12Hour(currentTimeStr),
              style: AppTextStyles.headingBold.copyWith(
                color: AppColors.pureWhite,
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            child: Text(
              timeLeftStr,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.pureWhite,
              ),
            ),
          ),

          Positioned(bottom: 160, child: AddressCard()),
          Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child: TimeContainer(timings: timings),
          ),
          ViewPrayerTimingsCard(),
        ],
      ),
    );
  }
}
