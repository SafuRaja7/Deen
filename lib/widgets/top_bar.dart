import 'package:deen/core/configs/configs.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String image;
  final String title;
  const TopBar({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Row(
        crossAxisAlignment: .end,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios, color: AppColors.textDark),
          ),
          Image.asset(image, height: 30),
          SizedBox(width: 10),
          Text(title, style: AppText.h2.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
