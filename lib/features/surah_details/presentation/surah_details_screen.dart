import 'dart:convert';
import 'dart:developer';

import 'package:deen/core/configs/configs.dart';
import 'package:deen/core/models/ayah.dart';
import 'package:deen/core/utils/app_utils.dart';
import 'package:deen/core/utils/static_assets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:deen/widgets/skeleton.dart';

part 'widgets/custom_top_bar.dart';
part 'widgets/surah_details_body.dart';
part '../data/surah_details_repository.dart';
part '../bloc/surah_details_bloc.dart';
part '../bloc/surah_details_event.dart';
part '../bloc/surah_details_state.dart';
part 'widgets/surah_details_skeleton.dart';

class SurahDetailsScreen extends StatelessWidget {
  const SurahDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final surahNumber = ModalRoute.of(context)?.settings.arguments as int? ?? 1;

    return BlocProvider(
      create: (context) =>
          SurahDetailsBloc()..add(LoadSurahDetailsData(surahNumber)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: const SurahDetailsBody(),
      ),
    );
  }
}
