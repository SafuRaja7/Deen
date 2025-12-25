import 'package:deen/core/utils/statis_assets.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/prayer_time.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PrayerTime currentPrayer = PrayerTime.fajar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBeige,
      body: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.55,
            width: double.infinity,
            decoration: BoxDecoration(gradient: currentPrayer.gradient),
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
                        Color(0xff000000).withValues(alpha: 0.55),
                        Color(0xff000000).withValues(alpha: 0.55),
                        Color(0xff000000).withValues(alpha: 0.55),
                      ],
                    ),
                  ),
                ),

                Image(image: AssetImage(StaticAssets.mosque)),
                Positioned(
                  top: 70,
                  left: 40,
                  child: Image(
                    image: AssetImage(StaticAssets.leftLattern),
                    height: 60,
                  ),
                ),
                Positioned(
                  top: 70,
                  right: 40,
                  child: Image(
                    image: AssetImage(StaticAssets.rightLattern),
                    height: 50,
                  ),
                ),
                Positioned(
                  top: 115,
                  right: 42,
                  child: Image(
                    image: AssetImage(StaticAssets.rightLattern),
                    height: 50,
                  ),
                ),
                Positioned(
                  top: 115,
                  right: 100,
                  left: 100,
                  child: Image(
                    image: AssetImage(StaticAssets.halfMoon),
                    height: 100,
                  ),
                ),
                Positioned(
                  top: 130,
                  right: 90,
                  left: 100,
                  child: Image(
                    image: AssetImage(StaticAssets.centerLattern),
                    height: 40,
                  ),
                ),
                Positioned(
                  top: 60,
                  child: Container(
                    padding:
                        EdgeInsets.all(5) +
                        EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        '3 Dhul-Hijjah, 1446',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Switch Variants:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: PrayerTime.values.map((prayer) {
              return ChoiceChip(
                label: Text(prayer.displayName),
                selected: currentPrayer == prayer,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      currentPrayer = prayer;
                    });
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
