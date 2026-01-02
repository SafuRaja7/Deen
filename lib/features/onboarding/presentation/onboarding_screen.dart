import 'package:deen/core/configs/configs.dart';
import 'package:deen/core/router/routes.dart';
import 'package:deen/features/home/data/home_repository.dart';
import 'package:deen/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'widgets/onboarding_body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: const OnboardingBody()),
    );
  }
}
