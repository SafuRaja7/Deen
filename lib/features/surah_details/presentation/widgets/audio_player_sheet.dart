part of '../surah_details_screen.dart';

class AudioPlayerSheet extends StatefulWidget {
  const AudioPlayerSheet({super.key});

  @override
  State<AudioPlayerSheet> createState() => _AudioPlayerSheetState();
}

class _AudioPlayerSheetState extends State<AudioPlayerSheet> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahDetailsBloc, SurahDetailsState>(
      builder: (context, state) {
        if (state.playingAyahNumber == null) return const SizedBox.shrink();

        final position = _dragValue ?? state.position.inMilliseconds.toDouble();
        final duration = state.duration.inMilliseconds.toDouble();

        return Container(
          margin: Space.a.t10,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.black.withValues(alpha: 0.1),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.1),
                offset: const Offset(0, -2),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: Space.a.t20,
                child: Row(
                  children: [
                    Text(
                      state.surahDetail?.englishName ?? "",
                      style: AppText.h2.copyWith(fontWeight: FontWeight.bold),
                    ),

                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.read<SurahDetailsBloc>().add(
                          CloseAudioPlayer(),
                        );
                      },
                      child: Container(
                        padding: Space.a.t05,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1),
              Padding(
                padding: Space.h.t20 + Space.only(0, 0, 10, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.read<SurahDetailsBloc>().add(
                        ToggleAyahAudio(),
                      ),
                      child: Container(
                        padding: Space.a.t20,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: state.isAudioLoading
                            ? const SizedBox(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: AppColors.primary,
                                ),
                              )
                            : Icon(
                                state.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: AppColors.primary,
                                size: 35,
                              ),
                      ),
                    ),
                    Space.x.t15,
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return GestureDetector(
                            onHorizontalDragUpdate: (details) {
                              if (state.isAudioLoading) return;
                              final double width = constraints.maxWidth;
                              final double relativeX = details.localPosition.dx;
                              final double newProgress = (relativeX / width)
                                  .clamp(0.0, 1.0);
                              setState(() {
                                _dragValue = newProgress * duration;
                              });
                            },
                            onHorizontalDragEnd: (details) {
                              if (_dragValue != null) {
                                context.read<SurahDetailsBloc>().add(
                                  SeekAudio(
                                    Duration(milliseconds: _dragValue!.toInt()),
                                  ),
                                );
                                setState(() {
                                  _dragValue = null;
                                });
                              }
                            },
                            child: state.isAudioLoading
                                ? Shimmer.fromColors(
                                    baseColor: AppColors.black.withValues(
                                      alpha: 0.1,
                                    ),
                                    highlightColor: AppColors.black.withValues(
                                      alpha: 0.05,
                                    ),
                                    child: const _WaveformVisual(progress: 0),
                                  )
                                : _WaveformVisual(
                                    progress: duration > 0
                                        ? position / duration
                                        : 0,
                                  ),
                          );
                        },
                      ),
                    ),
                    Space.x.t10,
                    state.isAudioLoading
                        ? Shimmer.fromColors(
                            baseColor: AppColors.black.withValues(alpha: 0.1),
                            highlightColor: AppColors.black.withValues(
                              alpha: 0.05,
                            ),
                            child: Container(
                              height: 20,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          )
                        : Text(
                            "${_formatDuration(Duration(milliseconds: position.toInt()))}/${_formatDuration(state.duration)}",
                            style: AppText.b1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ),
              Space.y.t15,
            ],
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}

class _WaveformVisual extends StatelessWidget {
  final double progress;
  const _WaveformVisual({required this.progress});

  @override
  Widget build(BuildContext context) {
    final List<double> heights = [
      15, 25, 20, 15, 30, 40, 25, 15, 20, 15, //
      15, 25, 20, 15, 30, 40, 25, 15, 20, 15, //
      15, 25, 20, 15, 30, 40, 25, 15, 20, 15, //
      15, 25, 20, 15, 30, 40, 25, 15, 20, 15, //
    ];

    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(heights.length, (index) {
          final isActive = index / heights.length < progress;
          return Container(
            width: 3,
            height: heights[index],
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.black.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
      ),
    );
  }
}
