part of '../quran_screen.dart';

class PrevRecordCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const PrevRecordCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: AppProps.card,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  title,
                  style: AppText.b2.copyWith(color: AppColors.textSub),
                ),
                Text(
                  subtitle,
                  style: AppText.b1.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 8.un()),
        ],
      ),
    );
  }
}
