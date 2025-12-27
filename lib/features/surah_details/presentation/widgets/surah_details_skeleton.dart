part of '../surah_details_screen.dart';

class SurahDetailsSkeleton extends StatelessWidget {
  const SurahDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Placeholder for TopBar if needed, but usually we keep the TopBar visible
        Expanded(
          child: SingleChildScrollView(
            padding: Space.h.t20,
            child: Column(
              children: [
                Space.y.t30,
                const CardSkeleton(height: 120), // Placeholder for design1
                Space.y.t30,
                const TextSkeleton(width: 150, height: 30), // Title placeholder
                Space.y.t30,
                const CardSkeleton(height: 40), // Placeholder for design2
                Space.y.t30,
                // List of Ayah placeholders
                ...List.generate(5, (index) => const _AyahSkeleton()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AyahSkeleton extends StatelessWidget {
  const _AyahSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.un()),
      child: Container(
        padding: Space.a.t20,
        decoration: AppProps.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: TextSkeleton(width: 250, height: 25),
            ),
            Space.y.t20,
            const CardSkeleton(height: 15), // Divider placeholder
            Space.y.t20,
            const TextSkeleton(width: double.infinity, height: 15),
            Space.y.t10,
            const TextSkeleton(width: 200, height: 15),
            Space.y.t20,
            const Divider(),
            Row(
              children: List.generate(
                3,
                (index) => Container(
                  margin: Space.r.t15,
                  child: const CardSkeleton(
                    height: 35,
                    width: 35,
                    borderRadius: 5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
