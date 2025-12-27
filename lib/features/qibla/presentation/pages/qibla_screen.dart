import 'package:deen/core/theme/app_text_styles.dart';
import 'package:deen/core/utils/static_assets.dart';
import 'package:deen/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class QiblaScreen extends StatelessWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TopBar(image: StaticAssets.qibla, title: "Qibla Direction"),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Qibla Direction",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "0.0",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Image.asset(StaticAssets.compass),
              Image.asset(StaticAssets.compassQibla),
              const SizedBox(height: 20),
              Text(
                "Calibrate your device first.",
                style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
              ),
              Text(
                "Make sure you’re standing straight in order to get correct directions.",
                style: AppTextStyles.bodySmall.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
