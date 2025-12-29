part of '../presentation/surah_details_screen.dart';

class SurahDetailsBloc extends Bloc<SurahDetailsEvent, SurahDetailsState> {
  final SurahDetailsRepository _repository;
  final AudioPlayer _audioPlayer = AudioPlayer();

  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playerStateSubscription;

  SurahDetailsBloc({SurahDetailsRepository? repository})
    : _repository = repository ?? SurahDetailsRepository(),
      super(const SurahDetailsState()) {
    on<LoadSurahDetailsData>(_onLoadSurahDetailsData);
    on<LoadMoreAyahs>(_onLoadMoreAyahs);
    on<PlayAyahAudio>(_onPlayAyahAudio);
    on<ToggleAyahAudio>(_onToggleAyahAudio);
    on<SeekAudio>(_onSeekAudio);
    on<UpdateAudioProgress>(_onUpdateAudioProgress);
    on<CloseAudioPlayer>(_onCloseAudioPlayer);

    _audioPlayer.positionStream.listen((pos) {
      if (!isClosed &&
          _audioPlayer.processingState != ProcessingState.completed) {
        add(
          UpdateAudioProgress(
            position: pos,
            duration: _audioPlayer.duration ?? state.duration,
            isPlaying: _audioPlayer.playing,
            isAudioLoading:
                _audioPlayer.processingState == ProcessingState.loading ||
                _audioPlayer.processingState == ProcessingState.buffering,
          ),
        );
      }
    });

    _audioPlayer.durationStream.listen((dur) {
      if (dur != null &&
          !isClosed &&
          _audioPlayer.processingState != ProcessingState.completed) {
        add(
          UpdateAudioProgress(
            position: _audioPlayer.position,
            duration: dur,
            isPlaying: _audioPlayer.playing,
            isAudioLoading:
                _audioPlayer.processingState == ProcessingState.loading ||
                _audioPlayer.processingState == ProcessingState.buffering,
          ),
        );
      }
    });

    _audioPlayer.playerStateStream.listen((playerState) {
      if (isClosed) return;

      final processingState = playerState.processingState;
      final playing = playerState.playing;
      final completed = processingState == ProcessingState.completed;
      final loading =
          processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering;

      log("Audio State: $processingState, Playing: $playing");

      // When completed, we force position to zero and isPlaying/isLoading to false
      add(
        UpdateAudioProgress(
          position: completed ? Duration.zero : _audioPlayer.position,
          duration: _audioPlayer.duration ?? state.duration,
          isPlaying: playing && !completed,
          isAudioLoading: loading && !completed,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }

  Future<void> _onToggleAyahAudio(
    ToggleAyahAudio event,
    Emitter<SurahDetailsState> emit,
  ) async {
    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
    } else {
      if (_audioPlayer.processingState == ProcessingState.completed) {
        await _audioPlayer.seek(Duration.zero);
      }
      await _audioPlayer.play();
    }
  }

  Future<void> _onSeekAudio(
    SeekAudio event,
    Emitter<SurahDetailsState> emit,
  ) async {
    await _audioPlayer.seek(event.position);
  }

  void _onUpdateAudioProgress(
    UpdateAudioProgress event,
    Emitter<SurahDetailsState> emit,
  ) {
    emit(
      state.copyWith(
        position: event.position,
        duration: event.duration,
        isPlaying: event.isPlaying,
        isAudioLoading: event.isAudioLoading,
      ),
    );
  }

  Future<void> _onPlayAyahAudio(
    PlayAyahAudio event,
    Emitter<SurahDetailsState> emit,
  ) async {
    try {
      await _audioPlayer.stop();

      emit(
        state.copyWith(
          playingAyahNumber: event.ayahNumber,
          isAudioLoading: true,
          isPlaying: false,
          position: Duration.zero,
          duration: Duration.zero,
        ),
      );

      final prefs = await SharedPreferences.getInstance();
      final cachedNumber = prefs.getInt('cached_ayah_number');
      final cachedData = prefs.getString('cached_audio_base64');

      Uint8List? audioBytes;

      if (cachedNumber == event.ayahNumber && cachedData != null) {
        log("✅ Loading Ayah ${event.ayahNumber} from SharedPreferences");
        audioBytes = base64Decode(cachedData);
      } else {
        final audioInfo = await _repository.fetchAyahAudio(event.ayahNumber);
        final audioUrl = audioInfo['audio'] ?? audioInfo['audioSecondary'];

        if (audioUrl == null) {
          log("No audio URL found for Ayah ${event.ayahNumber}");
          emit(state.copyWith(isAudioLoading: false));
          return;
        }

        log("🌐 Downloading Ayah ${event.ayahNumber}...");
        final response = await http.get(Uri.parse(audioUrl));

        if (response.statusCode == 200) {
          audioBytes = response.bodyBytes;

          // Save to SharedPreferences (Replaces previous)
          log("💾 Saving Ayah ${event.ayahNumber} to SharedPreferences");
          await prefs.setInt('cached_ayah_number', event.ayahNumber);
          await prefs.setInt('cached_surah_number', state.surahNumber ?? 0);
          await prefs.setString(
            'cached_surah_name',
            state.surahDetail?.englishName ?? "",
          );
          await prefs.setString(
            'cached_audio_base64',
            base64Encode(audioBytes),
          );
        } else {
          throw Exception("Failed to download audio");
        }
      }

      final filePath = await _saveAudioToTempFile(audioBytes, event.ayahNumber);

      await _audioPlayer.setFilePath(filePath);
      await _audioPlayer.play();

      emit(state.copyWith(audioFilePath: filePath));
    } catch (e) {
      log("Error playing audio: $e");
      emit(state.copyWith(isAudioLoading: false));
    }
  }

  void _onCloseAudioPlayer(
    CloseAudioPlayer event,
    Emitter<SurahDetailsState> emit,
  ) {
    _audioPlayer.stop();
    emit(
      state.copyWith(
        playingAyahNumber: null,
        isPlaying: false,
        position: Duration.zero,
        duration: Duration.zero,
        audioFilePath: null,
      ),
    );
  }

  Future<void> _onLoadSurahDetailsData(
    LoadSurahDetailsData event,
    Emitter<SurahDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SurahDetailsStatus.loading,
        surahNumber: event.surahNumber,
        hasMore: true,
      ),
    );
    try {
      final surahDetail = await _repository.fetchSurahDetail(
        event.surahNumber,
        offset: 0,
        limit: 5,
      );
      emit(
        state.copyWith(
          status: SurahDetailsStatus.success,
          surahDetail: surahDetail,
          hasMore: surahDetail.ayahs.length == 5,
        ),
      );

      if (event.initialAyahNumber != null) {
        add(PlayAyahAudio(event.initialAyahNumber!));
      }
    } catch (e) {
      emit(
        state.copyWith(status: SurahDetailsStatus.failure, error: e.toString()),
      );
    }
  }

  Future<void> _onLoadMoreAyahs(
    LoadMoreAyahs event,
    Emitter<SurahDetailsState> emit,
  ) async {
    if (state.status != SurahDetailsStatus.success ||
        state.loadingMore ||
        !state.hasMore ||
        state.surahDetail == null) {
      return;
    }

    emit(state.copyWith(loadingMore: true));

    try {
      final int offset = state.surahDetail!.ayahs.length;
      final nextSurahDetail = await _repository.fetchSurahDetail(
        state.surahNumber!,
        offset: offset,
        limit: 5,
      );

      final combinedAyahs = [
        ...state.surahDetail!.ayahs,
        ...nextSurahDetail.ayahs,
      ];

      emit(
        state.copyWith(
          loadingMore: false,
          surahDetail: SurahDetail(
            number: state.surahDetail!.number,
            name: state.surahDetail!.name,
            englishName: state.surahDetail!.englishName,
            englishNameTranslation: state.surahDetail!.englishNameTranslation,
            revelationType: state.surahDetail!.revelationType,
            numberOfAyahs: state.surahDetail!.numberOfAyahs,
            ayahs: combinedAyahs,
          ),
          hasMore: nextSurahDetail.ayahs.length == 5,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadingMore: false, error: e.toString()));
    }
  }

  Future<String> _saveAudioToTempFile(Uint8List bytes, int ayahNumber) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/ayah_$ayahNumber.mp3');
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }
}
