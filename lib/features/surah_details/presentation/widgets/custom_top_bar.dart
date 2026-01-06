part of '../surah_details_screen.dart';

class CustomTopBar extends StatelessWidget {
  final String title;
  final int currentSurahNumber;
  const CustomTopBar({
    super.key,
    required this.title,
    required this.currentSurahNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Space.h.t20 + Space.only(20.un()),
      decoration: const BoxDecoration(color: AppColors.primary),
      child: Column(
        mainAxisAlignment: .end,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.6),
                    width: 1,
                  ),
                  borderRadius: 10.radius(),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: currentSurahNumber > 1
                          ? () {
                              context.read<SurahDetailsBloc>().add(
                                LoadSurahDetailsData(currentSurahNumber - 1),
                              );
                            }
                          : null,
                      child: Padding(
                        padding: Space.h.t20,
                        child: Icon(Icons.arrow_left, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 19.un(),
                      child: VerticalDivider(
                        color: Colors.white.withValues(alpha: 0.6),
                        thickness: 1,
                        width: 1,
                      ),
                    ),
                    Space.x.t30,
                    Text(
                      '$currentSurahNumber- $title',
                      style: AppText.b1.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Space.x.t30,
                    SizedBox(
                      height: 19.un(),
                      child: VerticalDivider(
                        color: Colors.white.withValues(alpha: 0.6),
                        thickness: 1,
                        width: 1,
                      ),
                    ),
                    InkWell(
                      onTap: currentSurahNumber < 114
                          ? () {
                              context.read<SurahDetailsBloc>().add(
                                LoadSurahDetailsData(currentSurahNumber + 1),
                              );
                            }
                          : null,
                      child: Padding(
                        padding: Space.h.t20,
                        child: Icon(Icons.arrow_right, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_back_ios, color: AppColors.primary),
            ],
          ),
          Space.y.t30,
        ],
      ),
    );
  }
}
