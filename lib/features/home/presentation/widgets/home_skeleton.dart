part of '../home_screen.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Card Skeleton
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.55,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          // Quran Track Card Skeleton
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: CardSkeleton(height: 100),
          ),
          const SizedBox(height: 10),
          // Home Features Row Skeleton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => const CardSkeleton(height: 80, width: 80),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Content Sections Skeleton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextSkeleton(width: 150),
                const SizedBox(height: 10),
                const CardSkeleton(height: 180),
                const SizedBox(height: 20),
                const TextSkeleton(width: 180),
                const SizedBox(height: 10),
                const CardSkeleton(height: 150),
                const SizedBox(height: 20),
                const TextSkeleton(width: 150),
                const SizedBox(height: 10),
                ...List.generate(
                  3,
                  (index) => const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: CardSkeleton(height: 100),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
