part of '../home_screen.dart';

class FaithCard extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  final VoidCallback onTap;
  const FaithCard(this.image, this.title, this.desc, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.pureWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(image),
          ),
          SizedBox(height: 15),
          Text(
            title,
            style: AppTextStyles.bodyNormal.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            desc,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.secondaryDark,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Text(
                "Tap to Read",
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primaryGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryGold,
                size: 15,
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
