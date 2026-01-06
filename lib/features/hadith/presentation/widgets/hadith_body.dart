import 'package:deen/core/configs/configs.dart';
import 'package:deen/core/router/routes.dart';
import 'package:deen/core/utils/app_utils.dart';
import 'package:deen/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/hadith/bloc/hadith_bloc.dart';
import 'package:deen/features/hadith/bloc/hadith_state.dart';

class HadithBody extends StatelessWidget {
  const HadithBody({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return BlocBuilder<HadithBloc, HadithState>(
      builder: (context, state) {
        if (state.status == HadithStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == HadithStatus.failure) {
          return Center(child: Text('Error: ${state.error}'));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              TopBar(title: '📜 Hadith'),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: Space.a.t20,
                itemCount: AppUtils.hadithBooks.length,
                separatorBuilder: (context, index) => Space.y.t20,
                itemBuilder: (context, index) {
                  final book = AppUtils.hadithBooks[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.hadithChapters,
                        arguments: {
                          'bookSlug': book['slug'],
                          'bookName': book['book'],
                        },
                      );
                    },
                    child: Container(
                      padding: Space.a.t25,
                      decoration: AppProps.card,
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Container(
                            padding: Space.a.t20,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: .15),
                              borderRadius: 10.radius(),
                            ),
                            child: Text(
                              (index + 1).toString(),
                              style: AppText.b2.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Space.x.t25,
                          Expanded(
                            child: Text(
                              book['book'],
                              style: AppText.b1.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            book['arabic'],
                            style: AppText.b1.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
