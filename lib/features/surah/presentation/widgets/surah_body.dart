import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/surah/bloc/surah_bloc.dart';
import 'package:deen/features/surah/bloc/surah_state.dart';

class SurahBody extends StatelessWidget {
  const SurahBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahBloc, SurahState>(
      builder: (context, state) {
        if (state.status == SurahStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (state.status == SurahStatus.failure) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return const Center(
          child: Text('Welcome to Surah Screen'),
        );
      },
    );
  }
}
