import 'package:deen/core/router/router.dart';
import 'package:deen/features/home/presentation/home_screen.dart';
import 'package:deen/features/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final prefs = await SharedPreferences.getInstance();
  final isFirstRun = prefs.getBool('is_first_run') ?? true;

  runApp(DeenApp(isFirstRun: isFirstRun));

  WidgetsBinding.instance.addPostFrameCallback((_) {
    Future.delayed(const Duration(milliseconds: 500), () {
      FlutterNativeSplash.remove();
    });
  });
}

class DeenApp extends StatelessWidget {
  final bool isFirstRun;
  const DeenApp({super.key, required this.isFirstRun});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: OnboardingScreen(),
      onGenerateRoute: onGenerateRoutes,
    );
  }
}
