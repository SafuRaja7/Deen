import 'package:deen/core/configs/configs.dart';
import 'package:deen/features/hadith/bloc/hadith_bloc.dart';
import 'package:deen/features/hadith/bloc/hadith_event.dart';
import 'package:deen/features/hadith/bloc/hadith_state.dart';
import 'package:deen/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HadithListScreen extends StatefulWidget {
  final String bookSlug;
  final String chapterNumber;
  final String chapterName;

  const HadithListScreen({
    super.key,
    required this.bookSlug,
    required this.chapterNumber,
    required this.chapterName,
  });

  @override
  State<HadithListScreen> createState() => _HadithListScreenState();
}

class _HadithListScreenState extends State<HadithListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HadithBloc>().add(
      LoadHadiths(
        bookSlug: widget.bookSlug,
        chapterNumber: widget.chapterNumber,
      ),
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HadithBloc>().add(
        LoadHadiths(
          bookSlug: widget.bookSlug,
          chapterNumber: widget.chapterNumber,
          loadMore: true,
        ),
      );
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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<HadithBloc, HadithState>(
          builder: (context, state) {
            return Column(
              children: [
                TopBar(title: widget.chapterName),
                if (state.status == HadithStatus.loading &&
                    state.hadiths.isEmpty)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.status == HadithStatus.failure &&
                    state.hadiths.isEmpty)
                  Expanded(child: Center(child: Text('Error: ${state.error}')))
                else
                  Expanded(
                    child: ListView.separated(
                      controller: _scrollController,
                      padding: Space.a.t20,
                      itemCount: state.hadiths.length + (state.hasMore ? 1 : 0),
                      separatorBuilder: (context, index) => Space.y.t20,
                      itemBuilder: (context, index) {
                        if (index >= state.hadiths.length) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final hadith = state.hadiths[index];
                        return Container(
                          padding: Space.a.t25,
                          decoration: AppProps.card,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: Space.a.t15,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: .15,
                                      ),
                                      borderRadius: 8.radius(),
                                    ),
                                    child: Text(
                                      hadith.hadithNumber,
                                      style: AppText.b2.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Space.x.t20,
                                  Container(
                                    padding: Space.h.t15 + Space.v.t05,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: .1,
                                      ),
                                      borderRadius: 20.radius(),
                                    ),
                                    child: Text(
                                      hadith.status,
                                      style: AppText.s2.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (hadith.headingEnglish != null ||
                                  hadith.headingArabic != null) ...[
                                Space.y.t20,
                                if (hadith.headingArabic != null)
                                  Text(
                                    hadith.headingArabic!,
                                    textAlign: TextAlign.right,
                                    style: AppText.b1.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                if (hadith.headingEnglish != null)
                                  Text(
                                    hadith.headingEnglish!,
                                    style: AppText.b2.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                              Space.y.t20,
                              Text(
                                hadith.hadithArabic,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: AppText.h3.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  height: 1.8,
                                ),
                              ),
                              Space.y.t20,
                              if (hadith.englishNarrator.isNotEmpty)
                                Text(
                                  hadith.englishNarrator,
                                  style: AppText.b2.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              Text(
                                hadith.hadithEnglish,
                                style: AppText.b2.copyWith(
                                  color: AppColors.black.withValues(alpha: .8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Space.y.t15,
                              if (hadith.hadithUrdu.isNotEmpty) ...[
                                Text(
                                  hadith.hadithUrdu,
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: AppText.b2.copyWith(
                                    color: AppColors.black.withValues(
                                      alpha: .7,
                                    ),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
