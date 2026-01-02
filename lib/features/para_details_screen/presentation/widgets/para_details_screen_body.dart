import 'dart:math';
import 'package:deen/core/configs/configs.dart';
import 'package:deen/core/models/ayah.dart';
import 'package:deen/core/utils/static_assets.dart';
import 'package:deen/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:deen/features/para_details_screen/bloc/para_details_screen_bloc.dart';
import 'package:deen/features/para_details_screen/bloc/para_details_screen_state.dart';

class ParaDetailsScreenBody extends StatefulWidget {
  const ParaDetailsScreenBody({super.key});

  @override
  State<ParaDetailsScreenBody> createState() => _ParaDetailsScreenBodyState();
}

class _ParaDetailsScreenBodyState extends State<ParaDetailsScreenBody> {
  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParaDetailsScreenBloc, ParaDetailsScreenState>(
      builder: (context, state) {
        if (state.status == ParaDetailsScreenStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == ParaDetailsScreenStatus.failure) {
          return Center(child: Text('Error: ${state.error}'));
        }

        final paraNumber = (ModalRoute.of(context)!.settings.arguments as int);

        // Group ayahs by page
        Map<int, List<AyahDetail>> pagesMap = {};
        for (var ayah in state.ayahs) {
          int pg = ayah.page ?? (state.ayahs.indexOf(ayah) ~/ 12);
          pagesMap.putIfAbsent(pg, () => []).add(ayah);
        }
        List<List<AyahDetail>> pagedAyahs = pagesMap.values.toList();

        return Column(
          children: [
            TopBar(image: StaticAssets.logo, title: 'Para $paraNumber'),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pagedAyahs.length,
                reverse: true, // Multi-page Quran is often RTL
                itemBuilder: (context, index) {
                  // Advanced Page Flip Logic
                  double delta = index - _currentPage;

                  // Only animate the pages that are actually moving
                  bool isSwiping = delta <= 0 && delta > -1.0;
                  double rotation = isSwiping ? (delta * pi) : 0;

                  return Stack(
                    children: [
                      Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // perspective
                          ..rotateY(rotation),
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: Space.a.t30,
                          padding: Space.a.t30,
                          decoration: AppProps.card.copyWith(
                            color: const Color(0xFFFFF9F0), // Paper color
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(-5, 5),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Text.rich(
                              TextSpan(
                                children: pagedAyahs[index].map((ayah) {
                                  return TextSpan(
                                    children: [
                                      TextSpan(
                                        text: ayah.text,
                                        style: AppText.h2.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                          height: 2.0,
                                          fontSize: 22,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' - ',
                                        style: AppText.b1.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      // Shadow overlay for depth during flip
                      if (isSwiping)
                        Positioned.fill(
                          child: IgnorePointer(
                            child: Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(rotation),
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: Space.a.t30,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(
                                    alpha: (delta.abs() * 0.2).clamp(0, 0.2),
                                  ),
                                  borderRadius: 15.radius(),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            Container(
              padding: Space.v.t10 + Space.h.t30,
              decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    offset: const Offset(0, -2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Page ${(_currentPage + 1).toInt()}',
                    style: AppText.b2.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Total Pages: ${pagedAyahs.length}',
                    style: AppText.b2.copyWith(color: AppColors.textSub),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
