import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/surah/bloc/surah_bloc.dart';
import 'package:deen/features/surah/bloc/surah_event.dart';
import 'package:deen/features/surah/presentation/widgets/surah_body.dart';

class SurahScreen extends StatelessWidget {
  const SurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurahBloc()..add(LoadSurahData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Surah'),
        ),
        body: const SurahBody(),
      ),
    );
  }
}
