import 'dart:ui';

import 'package:deen/core/providers/app_provider.dart';
import 'package:deen/core/theme/app_colors.dart';
import 'package:deen/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.read<AppProvider>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding:
              const EdgeInsets.all(5) +
              const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.textGrey.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: AppColors.pureWhite.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.pin_drop_outlined,
                color: AppColors.pureWhite,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                appProvider.address,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.pureWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
