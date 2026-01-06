import 'package:deen/core/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/hadith/bloc/hadith_bloc.dart';
import 'package:deen/features/hadith/bloc/hadith_event.dart';
import 'package:deen/features/hadith/presentation/widgets/hadith_body.dart';

class HadithScreen extends StatelessWidget {
  const HadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return BlocProvider(
      create: (context) => HadithBloc()..add(LoadHadithData()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(child: const HadithBody()),
      ),
    );
  }
}
