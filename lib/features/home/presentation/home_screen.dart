import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:deen/core/configs/configs.dart';
import 'package:deen/core/constants/prayer_time.dart';
import 'package:deen/core/models/ayah.dart';
import 'package:deen/core/models/prayer_timings.dart';
import 'package:deen/core/router/routes.dart';
import 'package:deen/core/utils/app_utils.dart';
import 'package:deen/core/utils/static_assets.dart';
import 'package:deen/widgets/address_card.dart';
import 'package:deen/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/home/bloc/home_event.dart';
import 'package:deen/features/home/bloc/home_state.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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
part '../bloc/home_bloc.dart';
part '../data/prayer_repository.dart';
part '../data/verse_repository.dart';
part '../data/reflection_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return BlocProvider(
      create: (context) => HomeBloc(
        prayerRepository: PrayerRepository(),
        verseRepository: VerseOfTheDayRepository(),
        reflectionRepository: ReflectionRepository(),
      )..add(LoadHomeData()),
      child: const Scaffold(body: HomeBody()),
    );
  }
}
