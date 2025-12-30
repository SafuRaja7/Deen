part of '../home_screen.dart';

class ViewPrayerTimingsCard extends StatelessWidget {
  const ViewPrayerTimingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state.timings != null) {
              AppRoutes.prayerTimings.push(
                context,
                arguments: {
                  'address': state.address,
                  'initialTimings': state.timings,
                },
              );
            }
          },
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 15.un(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.1),
                ),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(StaticAssets.prayingPerson),
                      height: 12.un(),
                    ),
                    Space.x.t10,
                    Text(
                      'View All Prayer Timings',
                      style: AppText.b2 + AppColors.white,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
