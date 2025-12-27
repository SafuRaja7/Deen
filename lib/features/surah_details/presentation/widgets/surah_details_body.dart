part of '../surah_details_screen.dart';

class SurahDetailsBody extends StatefulWidget {
  const SurahDetailsBody({super.key});

  @override
  State<SurahDetailsBody> createState() => _SurahDetailsBodyState();
}

class _SurahDetailsBodyState extends State<SurahDetailsBody> {
  final ScrollController _scrollController = ScrollController();

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
    return BlocBuilder<SurahDetailsBloc, SurahDetailsState>(
      builder: (context, state) {
        if (state.status == SurahDetailsStatus.loading &&
            (state.surahDetail == null ||
                state.surahDetail!.number != state.surahNumber)) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
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
                padding: Space.h.t20,
                itemCount: surah.ayahs.length + 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        Space.y.t30,
                        Image.asset(StaticAssets.design1),
                        Space.y.t30,
                        Text(
                          surah.englishName,
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

                  return Padding(
                    padding: EdgeInsets.only(bottom: 5.un()),
                    child: Container(
                      width: double.infinity,
                      decoration: AppProps.card,
                      child: Column(
                        children: [
                          Padding(
                            padding: Space.a.t20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                (e) => Container(
                                  margin: Space.a.t15,
                                  decoration: BoxDecoration(
                                    color: AppTheme.c.primary.withValues(
                                      alpha: .3,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: Space.a.t10,
                                  child: Icon(
                                    e['icon'],
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Space.y.t60,
          ],
        );
      },
    );
  }
}
