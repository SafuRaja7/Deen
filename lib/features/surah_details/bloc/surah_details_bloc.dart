import 'dart:async';
import 'dart:developer';
import 'dart:math' hide log;
import 'package:deen/core/models/ayah.dart';
import 'package:deen/features/surah_details/data/surah_details_repository.dart';
import 'package:deen/features/surah_details/bloc/surah_details_event.dart';
import 'package:deen/features/surah_details/bloc/surah_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class SurahDetailsBloc extends Bloc<SurahDetailsEvent, SurahDetailsState> {
  final SurahDetailsRepository _repository;
  final AudioPlayer _audioPlayer = AudioPlayer();

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

      final audioInfo = await _repository.fetchAyahAudio(event.ayahNumber);
      final audioUrl = audioInfo['audio'] ?? audioInfo['audioSecondary'];
      final localPath = audioInfo['localPath'];

      if (localPath != null) {
        await _audioPlayer.setFilePath(localPath);
      } else if (audioUrl != null) {
        await _audioPlayer.setUrl(audioUrl);
      } else {
        emit(state.copyWith(isAudioLoading: false));
        return;
      }

      await _audioPlayer.play();

      final numberInSurah = event.numberInSurah ?? audioInfo['numberInSurah'];

      emit(
        state.copyWith(
          audioFilePath: localPath,
          isAudioLoading: false,
          numberInSurah: numberInSurah,
        ),
      );

      // Save Last Played
      if (state.surahDetail != null && numberInSurah != null) {
        await _repository.saveLastPlayed(
          surahNumber: state.surahDetail!.number,
          surahName: state.surahDetail!.englishName,
          ayahNumberInSurah: numberInSurah,
          globalAyahNumber: event.ayahNumber,
        );
      }
    } catch (e) {
      emit(state.copyWith(isAudioLoading: false));
    }
  }

  void _onCloseAudioPlayer(
    CloseAudioPlayer event,
    Emitter<SurahDetailsState> emit,
  ) {
    _audioPlayer.stop();
    emit(state.clearPlayer());
  }

  Future<void> _onLoadSurahDetailsData(
    LoadSurahDetailsData event,
    Emitter<SurahDetailsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: SurahDetailsStatus.loading,
        surahNumber: event.surahNumber,
        initialAyahNumberInSurah: event.initialAyahNumberInSurah,
        hasMore: true,
      ),
    );
    try {
      final int loadLimit = max(event.initialAyahNumberInSurah ?? 5, 5);
      final surahDetail = await _repository.fetchSurahDetail(
        event.surahNumber,
        offset: 0,
        limit: loadLimit,
      );
      emit(
        state.copyWith(
          status: SurahDetailsStatus.success,
          surahDetail: surahDetail,
          hasMore: surahDetail.ayahs.length == loadLimit,
        ),
      );

      // Save Last Read
      await _repository.saveLastRead(
        surahNumber: surahDetail.number,
        surahName: surahDetail.englishName,
        ayahNumber: event.initialAyahNumberInSurah ?? 1,
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
}
