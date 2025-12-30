part of '../home_screen.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading && state.timings == null) {
          return const HomeSkeleton();
        }

        if (state.status == HomeStatus.failure && state.timings == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Error: ${state.error}"),
                ElevatedButton(
                  onPressed: () => context.read<HomeBloc>().add(LoadHomeData()),
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopCard(),
              const QuranTrackCard(),
              Space.y.t15,
              const HomeFeaturesRow(),
              Space.y.t20,
              Padding(
                padding: Space.h.t30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Verse of the Day",
                      style: AppText.b2 + FontWeight.bold,
                    ),
                    Space.y.t20,
                    const VerseOfTheDayCard(),
                    Space.y.t20,
                    Text(
                      "Reflection of Peace",
                      style: AppText.b2 + FontWeight.bold,
                    ),
                    Space.y.t20,
                    const ReflectionOfPeaceCard(),
                    Space.y.t20,
                    Text(
                      "Revive Your Faith",
                      style: AppText.b2 + FontWeight.bold,
                    ),

                    ...AppUtils.list.asMap().entries.map((e) {
                      return FaithCard(
                        e.value["image"],
                        e.value["title"],
                        e.value["desc"],
                        () {},
                      );
                    }),
                    Space.y.t20,
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
