part of '../quran_screen.dart';

class ParaCard extends StatelessWidget {
  final Map<String, dynamic> para;
  const ParaCard({super.key, required this.para});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Space.a.t20,
      decoration: AppProps.card,
      child: Row(
        children: [
          Container(
            padding: Space.a.t20,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: 5.radius(),
            ),
            child: Center(
              child: Text(
                para['number'].toString(),
                style: AppText.b3.copyWith(color: AppColors.black),
              ),
            ),
          ),
          Space.x.t20,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                para['englishText'],
                style: AppText.b1.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                para['englishTranslation'],
                style: AppText.b2.copyWith(
                  color: AppColors.textSub,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            para['arabicText'],
            style: AppText.b1.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
