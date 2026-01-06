import 'package:deen/core/configs/configs.dart';
import 'package:deen/core/router/routes.dart';
import 'package:deen/features/hadith/bloc/hadith_bloc.dart';
import 'package:deen/features/hadith/bloc/hadith_event.dart';
import 'package:deen/features/hadith/bloc/hadith_state.dart';
import 'package:deen/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HadithChaptersScreen extends StatefulWidget {
  final String bookSlug;
  final String bookName;

  const HadithChaptersScreen({
    super.key,
    required this.bookSlug,
    required this.bookName,
  });

  @override
  State<HadithChaptersScreen> createState() => _HadithChaptersScreenState();
}

class _HadithChaptersScreenState extends State<HadithChaptersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HadithBloc>().add(LoadHadithChapters(widget.bookSlug));
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HadithBloc, HadithState>(
          builder: (context, state) {
            return Column(
              children: [
                TopBar(title: widget.bookName),
                if (state.status == HadithStatus.loading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.status == HadithStatus.failure)
                  Expanded(child: Center(child: Text('Error: ${state.error}')))
                else
                  Expanded(
                    child: ListView.separated(
                      padding: Space.a.t20,
                      itemCount: state.chapters.length,
                      separatorBuilder: (context, index) => Space.y.t20,
                      itemBuilder: (context, index) {
                        final chapter = state.chapters[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.hadithList,
                              arguments: {
                                'bookSlug': chapter.bookSlug,
                                'chapterNumber': chapter.chapterNumber,
                                'chapterName': chapter.chapterEnglish,
                              },
                            );
                          },
                          child: Container(
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
                                        chapter.chapterNumber,
                                        style: AppText.b2.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Space.x.t20,
                                    Expanded(
                                      child: Text(
                                        chapter.chapterArabic,
                                        textAlign: TextAlign.right,
                                        style: AppText.b1.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Space.y.t15,
                                Text(
                                  chapter.chapterEnglish,
                                  style: AppText.b2.copyWith(
                                    color: AppColors.black.withValues(
                                      alpha: .7,
                                    ),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (chapter.chapterUrdu.isNotEmpty) ...[
                                  Space.y.t10,
                                  Text(
                                    chapter.chapterUrdu,
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
