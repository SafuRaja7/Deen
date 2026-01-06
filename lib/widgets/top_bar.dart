import 'package:deen/core/configs/configs.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String? image;
  final String title;
  const TopBar({super.key, this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        padding: Space.h.t30 + Space.v.t20,
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: AppColors.textDark.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
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
            if (image != null) ...[
              Image.asset(image ?? '', height: 10.un()),
              Space.x.t20,
            ],
            Text(
              title,
              style: AppText.h3.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
