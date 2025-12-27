import 'package:deen/core/configs/configs.dart';
import 'package:flutter/material.dart';

enum AppButtonVariant { filled, bordered }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? trailingIcon;
  final IconData? leadingIcon;
  final bool isLoading;
  final bool fullWidth;
  final double? width;
  final double height;
  final double borderRadius;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.trailingIcon,
    this.leadingIcon,
    this.isLoading = false,
    this.fullWidth = true,
    this.width,
    this.height = 56,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final isFilled = variant == AppButtonVariant.filled;

    return SizedBox(
      width: fullWidth ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isFilled ? AppColors.primary : Colors.transparent,

          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: isFilled
                ? BorderSide.none
                : const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(leadingIcon, size: 20),
                  Text(
                    text,
                    style: AppText.b2.copyWith(
                      color: isFilled ? AppColors.white : AppColors.primary,
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    Icon(
                      trailingIcon,
                      size: 20,
                      color: isFilled ? AppColors.white : AppColors.primary,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
