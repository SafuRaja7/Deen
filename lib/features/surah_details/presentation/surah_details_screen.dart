import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:deen/core/configs/configs.dart';
import 'package:deen/core/models/ayah.dart';
import 'package:deen/core/utils/app_utils.dart';
import 'package:deen/core/utils/static_assets.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:deen/widgets/skeleton.dart';
import 'package:just_audio/just_audio.dart';

part 'widgets/custom_top_bar.dart';
part 'widgets/surah_details_body.dart';
part '../data/surah_details_repository.dart';
part '../bloc/surah_details_bloc.dart';
part '../bloc/surah_details_event.dart';
part '../bloc/surah_details_state.dart';
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
    int? initialAyahNumber;

    if (args is int) {
      surahNumber = args;
    } else if (args is Map<String, dynamic>) {
      surahNumber = args['surahNumber'] ?? 1;
      initialAyahNumber = args['initialAyahNumber'];
    }

    return BlocProvider(
      create: (context) => SurahDetailsBloc()
        ..add(
          LoadSurahDetailsData(
            surahNumber,
            initialAyahNumber: initialAyahNumber,
          ),
        ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: const SurahDetailsBody(),
        bottomSheet: const AudioPlayerSheet(),
      ),
    );
  }
}
