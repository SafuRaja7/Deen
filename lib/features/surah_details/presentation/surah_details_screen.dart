import 'dart:async';
import 'dart:typed_data';

import 'package:deen/core/configs/configs.dart';
import 'package:deen/core/utils/app_utils.dart';
import 'package:deen/core/utils/static_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/widgets/skeleton.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shimmer/shimmer.dart';

import 'package:deen/features/surah_details/bloc/surah_details_bloc.dart';
import 'package:deen/features/surah_details/bloc/surah_details_event.dart';
import 'package:deen/features/surah_details/bloc/surah_details_state.dart';

part 'widgets/custom_top_bar.dart';
part 'widgets/surah_details_body.dart';
part 'widgets/surah_details_skeleton.dart';
part 'widgets/audio_player_sheet.dart';

class BytesAudioSource extends StreamAudioSource {
  final Uint8List _bytes;
  BytesAudioSource(this._bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= _bytes.length;
    return StreamAudioResponse(
      sourceLength: _bytes.length,
      contentLength: end - start,
      offset: start,
      contentType: 'audio/mpeg',
      stream: Stream.value(_bytes.sublist(start, end)),
    );
  }
}

class SurahDetailsScreen extends StatelessWidget {
  const SurahDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final args = ModalRoute.of(context)?.settings.arguments;
    int surahNumber = 1;
    int? initialGlobalAyahNumber;
    int? initialAyahNumberInSurah;

    if (args is int) {
      surahNumber = args;
    } else if (args is Map<String, dynamic>) {
      surahNumber = args['surahNumber'] ?? 1;
      initialGlobalAyahNumber = args['initialAyahNumber'];
      initialAyahNumberInSurah = args['initialAyahNumberInSurah'];
    }

    return BlocProvider(
      create: (context) => SurahDetailsBloc()
        ..add(
          LoadSurahDetailsData(
            surahNumber,
            initialAyahNumber: initialGlobalAyahNumber,
            initialAyahNumberInSurah: initialAyahNumberInSurah,
          ),
        ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: const Stack(
          children: [
            SurahDetailsBody(),
            Align(alignment: Alignment.bottomCenter, child: AudioPlayerSheet()),
          ],
        ),
      ),
    );
  }
}
