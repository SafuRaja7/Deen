import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardSkeleton extends StatelessWidget {
  final double height;
  final double? width;
  final double borderRadius;

  const CardSkeleton({
    super.key,
    required this.height,
    this.width,
    this.borderRadius = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class TextSkeleton extends StatelessWidget {
  final double width;
  final double height;

  const TextSkeleton({super.key, required this.width, this.height = 20});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
