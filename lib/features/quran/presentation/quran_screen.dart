import 'package:deen/core/configs/configs.dart';
import 'package:deen/core/models/surah.dart';
import 'package:deen/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/quran/bloc/quran_bloc.dart';
import 'package:deen/features/quran/bloc/quran_event.dart';
import 'package:deen/features/quran/presentation/widgets/quran_body.dart';
import 'package:deen/core/utils/static_assets.dart';
import 'package:deen/widgets/skeleton.dart';
import 'package:deen/widgets/top_bar.dart';

part 'widgets/prev_record_card.dart';
part 'widgets/quran_skeleton.dart';
part 'widgets/surah_card.dart';
part 'widgets/para_card.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return BlocProvider(
      create: (context) => QuranBloc()..add(LoadQuranData()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(child: const QuranBody()),
      ),
    );
  }
}
