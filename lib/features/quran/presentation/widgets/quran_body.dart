import 'package:deen/core/router/routes.dart';
import 'package:deen/core/configs/configs.dart';
import 'package:deen/core/utils/app_utils.dart';
import 'package:deen/core/utils/static_assets.dart';
import 'package:deen/features/quran/presentation/quran_screen.dart';
import 'package:deen/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/quran/bloc/quran_bloc.dart';
import 'package:deen/features/quran/bloc/quran_event.dart';
import 'package:deen/features/quran/bloc/quran_state.dart';

class QuranBody extends StatelessWidget {
  const QuranBody({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return BlocBuilder<QuranBloc, QuranState>(
      builder: (context, state) {
        if (state.status == QuranStatus.loading) {
          return const QuranSkeleton();
        }

        if (state.status == QuranStatus.failure) {
          return Center(child: Text('Error: ${state.error}'));
        }

        final lastPlayedSurahName = state.lastPlayedSurahName ?? "None";
        final lastPlayedSurahNumber = state.lastPlayedSurahNumber;
        final lastPlayedAyahNumber = state.lastPlayedAyahNumber;
        final lastPlayedGlobalAyahNumber = state.lastPlayedGlobalAyahNumber;

        return SingleChildScrollView(
          child: Column(
            children: [
              TopBar(image: StaticAssets.logo, title: 'Al - Quran'),
              Space.y.t30,
              Padding(
                padding: Space.a.t20,
                child: Column(
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Flexible(
                          flex: 1,
                          child: PrevRecordCard(
                            title: "Last Read",
                            subtitle: "Al Bakarah 117",
                            onTap: () {},
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: PrevRecordCard(
                            title: "Last Played",
                            subtitle: lastPlayedSurahName != "None"
                                ? '$lastPlayedSurahName $lastPlayedAyahNumber'
                                : "None",
                            onTap: () {
                              if (lastPlayedSurahNumber != null &&
                                  lastPlayedSurahNumber > 0) {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.surahDetails,
                                  arguments: {
                                    'surahNumber': lastPlayedSurahNumber,
                                    'initialAyahNumber':
                                        lastPlayedGlobalAyahNumber,
                                    'initialAyahNumberInSurah':
                                        lastPlayedAyahNumber,
                                  },
                                ).then((_) {
                                  if (context.mounted) {
                                    context.read<QuranBloc>().add(
                                      LoadQuranData(),
                                    );
                                  }
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Space.y.t30,
                    SizedBox(
                      height: 15.un(),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: AppUtils.quranScreenListItems.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final isSelected = state.selectedIndex == index;
                          return InkWell(
                            onTap: () => context.read<QuranBloc>().add(
                              ChangeQuranTab(index),
                            ),
                            child: Container(
                              padding: Space.h.t20 + Space.v.t10,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.primary.withValues(alpha: .15),
                                borderRadius: 10.radius(),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                AppUtils.quranScreenListItems[index],
                                style: AppText.b1.copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Space.y.t20,
                    if (state.selectedIndex == 0)
                      ...state.surahs.map((surah) {
                        return Padding(
                          padding: Space.v.t10,
                          child: SurahCard(surah: surah),
                        );
                      })
                    else if (state.selectedIndex == 1)
                      ...AppUtils.paraNames.map((para) {
                        return Padding(
                          padding: Space.v.t10,
                          child: ParaCard(para: para),
                        );
                      }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
