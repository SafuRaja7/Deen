part of '../surah_details_screen.dart';

class SurahDetailsBody extends StatefulWidget {
  const SurahDetailsBody({super.key});

  @override
  State<SurahDetailsBody> createState() => _SurahDetailsBodyState();
}

class _SurahDetailsBodyState extends State<SurahDetailsBody> {
  final ScrollController _scrollController = ScrollController();
  bool _hasInitialJumped = false;
  bool _hasFinalScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<SurahDetailsBloc>().add(LoadMoreAyahs());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return BlocListener<SurahDetailsBloc, SurahDetailsState>(
      listenWhen: (previous, current) =>
          !_hasInitialJumped &&
          current.status == SurahDetailsStatus.success &&
          current.initialAyahNumberInSurah != null,
      listener: (context, state) {
        _hasInitialJumped = true;

        final int index = state.initialAyahNumberInSurah!;
        final double approxOffset = (index - 1) * 400.0;

        // Small delay to ensure ScrollController is attached and ready
        Future.delayed(const Duration(milliseconds: 100), () {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(approxOffset);
          }
        });
      },
      child: BlocBuilder<SurahDetailsBloc, SurahDetailsState>(
        builder: (context, state) {
          if (state.status == SurahDetailsStatus.loading &&
              (state.surahDetail == null ||
                  state.surahDetail!.number != state.surahNumber)) {
            return Column(
              children: [
                CustomTopBar(
                  title: "",
                  currentSurahNumber: state.surahNumber ?? 1,
                ),
                const Expanded(child: SurahDetailsSkeleton()),
              ],
            );
          }

          if (state.status == SurahDetailsStatus.failure) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (state.surahDetail == null) {
            return const Center(child: Text('No data found'));
          }

          final surah = state.surahDetail!;

          return Column(
            children: [
              CustomTopBar(
                title: surah.englishName,
                currentSurahNumber: surah.number,
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: Space.h.t20.copyWith(
                    bottom: state.playingAyahNumber != null ? 70.un() : 40.un(),
                  ),
                  itemCount: surah.ayahs.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          Space.y.t30,
                          Image.asset(StaticAssets.design1),
                          Space.y.t30,
                          Text(
                            surah.name,
                            style: AppText.h1.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Space.y.t30,
                          Image.asset(StaticAssets.design2, height: 25.un()),
                          Space.y.t30,
                        ],
                      );
                    }

                    if (index == surah.ayahs.length + 1) {
                      if (state.loadingMore) {
                        return Padding(
                          padding: Space.v.t20,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }
                      if (!state.hasMore) {
                        return Image.asset(
                          StaticAssets.dividerFrame,
                          height: 25.un(),
                        );
                      }
                      return SizedBox(height: 10.un());
                    }

                    final ayah = surah.ayahs[index - 1];
                    final bool isTarget =
                        state.initialAyahNumberInSurah == ayah.numberInSurah;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 5.un()),
                      child: Container(
                        key: ValueKey('ayah_${ayah.number}'),
                        width: double.infinity,
                        decoration: AppProps.card,
                        child: Builder(
                          builder: (context) {
                            if (isTarget && !_hasFinalScrolled) {
                              _hasFinalScrolled = true;
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (mounted) {
                                  Future.delayed(
                                    const Duration(milliseconds: 300),
                                    () {
                                      if (mounted && context.mounted) {
                                        Scrollable.ensureVisible(
                                          context,
                                          duration: const Duration(
                                            milliseconds: 1000,
                                          ),
                                          curve: Curves.easeInOut,
                                          alignment: 0.1,
                                        );
                                      }
                                    },
                                  );
                                }
                              });
                            }
                            return Column(
                              children: [
                                Padding(
                                  padding: Space.a.t20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        ayah.text,
                                        textAlign: TextAlign.right,
                                        style: AppText.h2.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Space.y.t20,
                                      Image.asset(
                                        StaticAssets.dividerFrame,
                                        height: 15.un(),
                                      ),
                                      Space.y.t20,
                                      Text(
                                        ayah.translation,
                                        style: AppText.b1.copyWith(
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: AppColors.black.withValues(alpha: 0.2),
                                ),
                                Row(
                                  children: [
                                    ...AppUtils.suarhDetailsFeature.map(
                                      (e) => InkWell(
                                        onTap: () {
                                          if (e['icon'] == Icons.play_arrow) {
                                            if (state.playingAyahNumber ==
                                                ayah.number) {
                                              context
                                                  .read<SurahDetailsBloc>()
                                                  .add(ToggleAyahAudio());
                                            } else {
                                              context
                                                  .read<SurahDetailsBloc>()
                                                  .add(
                                                    PlayAyahAudio(ayah.number),
                                                  );
                                            }
                                          }
                                        },
                                        child: Container(
                                          margin: Space.a.t15,
                                          decoration: BoxDecoration(
                                            color: AppTheme.c.primary
                                                .withValues(alpha: .3),
                                            borderRadius: 5.radius(),
                                          ),
                                          padding: Space.a.t10,
                                          child: Icon(
                                            (e['icon'] == Icons.play_arrow &&
                                                    state.playingAyahNumber ==
                                                        ayah.number &&
                                                    (state.isPlaying ||
                                                        state.isAudioLoading))
                                                ? Icons.pause
                                                : e['icon'],
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
