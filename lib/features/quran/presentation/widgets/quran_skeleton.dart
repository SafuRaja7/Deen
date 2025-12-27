part of '../quran_screen.dart';

class QuranSkeleton extends StatelessWidget {
  const QuranSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TopBar(image: StaticAssets.logo, title: 'Al - Quran'),
          Space.y.t30,
          Row(
            spacing: 10,
            children: List.generate(
              2,
              (index) => const Expanded(child: CardSkeleton(height: 80)),
            ),
          ),
          Space.y.t30,
          SizedBox(
            height: 15.un(),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return const CardSkeleton(height: 50, width: 100);
              },
            ),
          ),
          Space.y.t20,
          ...List.generate(
            5,
            (index) => const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: CardSkeleton(height: 90),
            ),
          ),
        ],
      ),
    );
  }
}
