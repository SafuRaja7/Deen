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
      padding: Space.h.t20,
      child: Row(
        crossAxisAlignment: .end,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.textDark,
              size: 8.un(),
            ),
          ),
          Image.asset(image, height: 10.un()),
          Space.x.t15,
          Text(title, style: AppText.b1.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
