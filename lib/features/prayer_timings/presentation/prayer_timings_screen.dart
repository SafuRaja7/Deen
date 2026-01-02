import 'package:deen/core/configs/configs.dart';
import 'package:deen/core/models/prayer_timings.dart';
import 'package:deen/core/utils/app_utils.dart';
import 'package:deen/core/utils/static_assets.dart';
import 'package:deen/widgets/address_card.dart';
import 'package:deen/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/prayer_timings/bloc/prayer_timings_bloc.dart';
import 'package:deen/features/prayer_timings/bloc/prayer_timings_event.dart';
import 'package:deen/features/prayer_timings/bloc/prayer_timings_state.dart';
import 'package:deen/features/prayer_timings/data/prayer_timings_repo.dart';

part 'widgets/prayer_timings_body.dart';
part 'widgets/time_card.dart';
part 'widgets/prayer_times_month_card.dart';
part 'widgets/date_card.dart';

class PrayerTimingsScreen extends StatelessWidget {
  const PrayerTimingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider(
      create: (context) =>
          PrayerTimingsBloc(
            repository: PrayerTimingsRepository(),
            initialMonth: now.month,
            initialYear: now.year,
            initialAddress: args['address'],
          )..add(
            LoadMonthlyTimings(
              address: args['address'],
              month: now.month,
              year: now.year,
            ),
          ),
      child: Builder(
        builder: (context) {
          App.init(context);
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: PrayerTimingsBody(timings: args['initialTimings']),
            ),
          );
        },
      ),
    );
  }
}
