import 'package:deen/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:deen/core/theme/app_theme.dart';

void main() {
  runApp(const DeenApp());
}

class DeenApp extends StatelessWidget {
  const DeenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
      routes: {'/main': (context) => const HomeScreen()},
    );
  }
}
