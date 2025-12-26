import 'package:deen/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String image;
  final String title;
  const TopBar({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundBeige,
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          Image.asset(image),
          Text(title),
        ],
      ),
    );
  }
}
