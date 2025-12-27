import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deen/core/theme/app_theme.dart';
import 'package:deen/features/home/presentation/pages/home_screen.dart';
import 'package:deen/core/providers/app_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
      child: const DeenApp(),
    ),
  );
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
