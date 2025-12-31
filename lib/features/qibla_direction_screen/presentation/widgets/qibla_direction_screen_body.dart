import 'dart:math' as math;
import 'package:deen/core/utils/static_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class QiblaDirectionScreenBody extends StatelessWidget {
  final double qiblaDirection;

  const QiblaDirectionScreenBody({super.key, required this.qiblaDirection});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.heading == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final heading = snapshot.data!.heading!;
        final compassAngle = -heading * math.pi / 180;

        // Your arrow image is tilted ~45° → compensate
        final qiblaAngle = (qiblaDirection - heading - 45) * math.pi / 180;

        return SizedBox(
          width: 320,
          height: 320,
          child: ClipOval(
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// 🧭 Compass background
                Transform.rotate(
                  angle: compassAngle,
                  child: Image.asset(
                    StaticAssets.compass,
                    width: 320,
                    height: 320,
                    fit: BoxFit.cover,
                  ),
                ),

                /// 🟡 Arrow + Kaaba rotate together
                Transform.rotate(
                  angle: qiblaAngle,
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// 🕋 Kaaba at arrow tip
                      Image.asset(StaticAssets.compassQibla, width: 28),
                      const SizedBox(height: 6),

                      /// Arrow
                      Image.asset(StaticAssets.qiblaArrow, width: 180),
                    ],
                  ),
                ),

                /// 🎯 Center pivot dot (optional, matches your design)
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
