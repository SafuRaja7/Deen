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
          padding: Space.a.t20,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ayah ${state.playingAyahNumber}",
                        style: AppText.h3.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        "${state.surahDetail?.englishName}",
                        style: AppText.b2.copyWith(color: AppColors.black),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<SurahDetailsBloc>().add(CloseAudioPlayer());
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Space.y.t15,
              SizedBox(
                height: 4,
                child: state.isAudioLoading
                    ? const LinearProgressIndicator(color: AppColors.primary)
                    : const SizedBox.shrink(),
              ),
              Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 8,
                      ),
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: AppColors.primary.withValues(
                        alpha: 0.2,
                      ),
                      thumbColor: AppColors.primary,
                    ),
                    child: Slider(
                      value: position.clamp(0, duration > 0 ? duration : 1.0),
                      max: duration > 0 ? duration : 1.0,
                      onChanged: (val) {
                        setState(() {
                          _dragValue = val;
                        });
                      },
                      onChangeEnd: (val) {
                        context.read<SurahDetailsBloc>().add(
                          SeekAudio(Duration(milliseconds: val.toInt())),
                        );
                        setState(() {
                          _dragValue = null;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: Space.h.t10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(
                            Duration(milliseconds: position.toInt()),
                          ),
                          style: AppText.b2,
                        ),
                        Text(
                          _formatDuration(state.duration),
                          style: AppText.b2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Space.y.t10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous, size: 30),
                    onPressed: () {},
                  ),
                  Space.x.t20,
                  GestureDetector(
                    onTap: () {
                      context.read<SurahDetailsBloc>().add(ToggleAyahAudio());
                    },
                    child: Container(
                      padding: Space.a.t15,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        (state.isPlaying || state.isAudioLoading)
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: AppColors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  Space.x.t20,
                  IconButton(
                    icon: const Icon(Icons.skip_next, size: 30),
                    onPressed: () {},
                  ),
                ],
              ),
              Space.y.t20,
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
