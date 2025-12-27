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
    final List<Map<String, dynamic>> dummyRecord = [
      {"title": "Last Read", "subtitle": "Al Bakarah 117"},
      {"title": "Last Played", "subtitle": "Al-Ma'idah"},
    ];

    return BlocBuilder<QuranBloc, QuranState>(
      builder: (context, state) {
        if (state.status == QuranStatus.loading) {
          return const QuranSkeleton();
        }

        if (state.status == QuranStatus.failure) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return SingleChildScrollView(
          padding: Space.a.t20,
          child: Column(
            children: [
              TopBar(image: StaticAssets.logo, title: 'Al - Quran'),
              Space.y.t30,
              Row(
                spacing: 10,
                children: [
                  ...dummyRecord.asMap().entries.map(
                    (e) => Flexible(
                      flex: 1,
                      child: PrevRecordCard(
                        title: e.value['title'],
                        subtitle: e.value['subtitle'],
                      ),
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
                      onTap: () =>
                          context.read<QuranBloc>().add(ChangeQuranTab(index)),
                      child: Container(
                        padding: Space.h.t20 + Space.v.t10,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.primary.withValues(alpha: .15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppUtils.quranScreenListItems[index],
                          style: AppText.b1.copyWith(
                            color: isSelected ? Colors.white : AppColors.black,
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
        );
      },
    );
  }
}
