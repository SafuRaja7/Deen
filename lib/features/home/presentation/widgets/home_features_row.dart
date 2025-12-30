part of '../home_screen.dart';

class HomeFeaturesRow extends StatelessWidget {
  const HomeFeaturesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Space.h.t30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: AppUtils.homeFeaturesRow.map((feature) {
          return Column(
            children: [
              InkWell(
                onTap: () => Navigator.pushNamed(context, feature['onTap']!),
                child: Container(
                  width: 33.un(),
                  height: 29.un(),
                  padding: const EdgeInsets.all(12),
                  decoration: AppProps.card,
                  child: Column(
                    children: [
                      Image.asset(feature['image']!, height: 10.un()),
                      Space.y.t05,
                      Text(
                        feature['title']!,
                        style: AppText.b3 + AppColors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
