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
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      decoration: AppProps.card,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          ClipRRect(borderRadius: 15.radius(), child: Image.asset(image)),
          Space.y.t20,
          Text(title, style: AppText.b1 + FontWeight.bold),
          Space.y.t20,
          Text(desc, style: AppText.b1 + AppColors.textSub),
          Space.y.t20,
          Row(
            children: [
              Text(
                "Tap to Read",
                style: AppText.b2 + FontWeight.bold + AppColors.primary,
              ),
              Space.x.t10,
              Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 15),
            ],
          ),
          Space.y.t20,
        ],
      ),
    );
  }
}
