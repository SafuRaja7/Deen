import 'dart:ui';
import 'package:deen/core/configs/configs.dart';
import 'package:deen/core/constants/prayer_time.dart';
import 'package:deen/core/models/ayah.dart';
import 'package:deen/core/models/prayer_timings.dart';
import 'package:deen/core/models/location_data.dart';
import 'package:deen/core/router/routes.dart';
import 'package:deen/core/utils/app_utils.dart';
import 'package:deen/core/utils/static_assets.dart';
import 'package:deen/widgets/address_card.dart';
import 'package:deen/widgets/skeleton.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/home/bloc/home_bloc.dart';
import 'package:deen/features/home/data/home_repository.dart';
import 'package:deen/features/home/bloc/home_event.dart';
import 'package:deen/features/home/bloc/home_state.dart';

part 'widgets/faith_card.dart';
part 'widgets/home_body.dart';
part 'widgets/home_features_row.dart';
part 'widgets/view_prayer_timings_card.dart';
part 'widgets/verse_of_the_day_card.dart';
part 'widgets/top_card.dart';
part 'widgets/time_container.dart';
part 'widgets/reflection_of_peace_card.dart';
part 'widgets/home_skeleton.dart';
part 'widgets/quran_track_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return BlocProvider(
      create: (context) =>
          HomeBloc(homeRepository: HomeRepository())..add(LoadHomeData()),
      child: const Scaffold(body: HomeBody()),
    );
  }
}
