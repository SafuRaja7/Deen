import 'dart:ui';
import 'package:deen/core/configs/configs.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String address;
  const AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: 50.radius(),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: Space.a.t10 + Space.h.t10,
          decoration: BoxDecoration(
            color: AppColors.textSub.withValues(alpha: 0.3),
            borderRadius: 50.radius(),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.pin_drop_outlined,
                color: AppColors.white,
                size: 16,
              ),
              Space.x.t10,
              Flexible(
                child: Text(
                  address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.b3 + AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
