import 'dart:ui';
import 'package:deen/core/configs/configs.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String address;
  const AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding:
              const EdgeInsets.all(5) +
              const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.textSub.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.pin_drop_outlined,
                color: AppColors.white,
                size: 16,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.b2.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
