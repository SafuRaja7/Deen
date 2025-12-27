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
              const SizedBox(height: 10),
              const HomeFeaturesRow(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Verse of the Day", style: AppText.b2),
                    const SizedBox(height: 10),
                    const VerseOfTheDayCard(),
                    const SizedBox(height: 20),
                    Text("Reflection of Peace", style: AppText.b2),
                    const SizedBox(height: 10),
                    const ReflectionOfPeaceCard(),
                    const SizedBox(height: 20),
                    Text("Revive Your Faith", style: AppText.b2),
                    const SizedBox(height: 10),
                    ...AppUtils.list.asMap().entries.map((e) {
                      return FaithCard(
                        e.value["image"],
                        e.value["title"],
                        e.value["desc"],
                        () {},
                      );
                    }),
                    const SizedBox(height: 40),
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
