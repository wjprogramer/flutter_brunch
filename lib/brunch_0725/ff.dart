
import 'dart:math';

import 'package:flutter/material.dart';

enum _FireFlyType {
  A, B, C, D, E
}

/// 螢火蟲
class FireFly5 {
  late double o1;
  double o2 = 0.0;
  double o3 = 0.0;

  double o2Vel = 0.01;
  double o3Vel = 0.007;
  double o3Vel2 = 0.038;

  double o3Max = 2.0;
  double o3Max2 = 10.0;

  // pos
  late double centerX;
  late double lineLength;

  late double originX;
  double originY = 0;
  late double bobX;
  late double bobY;

  // 單擺運動 Pendulum
  late double frequency;
  late double theta;

  late double angle;
  double aVel = 0.0;
  double aAcc = 0.0;

  double damping = 0.995;

  // type
  late _FireFlyType currentType;
  _FireFlyType? nextType;

  // type A、B
  int currTwinkCount = 0;
  late int targetTwinkCount;

  //
  double luminousMaxFrequency = pi / 50;
  double luminousMinFrequency = pi / 159;

  FireFly5({
    required this.originX,
    required this.lineLength,
  }) {
    var rand = Random();

    currentType = _FireFlyType.A;

    frequency = rand.nextDouble() * (luminousMaxFrequency - luminousMinFrequency) + luminousMinFrequency;
    theta = pi * 2 * rand.nextDouble();
    o1 = 0.5 + 0.3 * sin(theta);

    angle = 0;

    o3Vel2 = (o3Vel2 / 3) *  rand.nextDouble() + (o3Vel2 * 2 / 3);
    o3Max2 = (o3Max2 / 2) *  rand.nextDouble() + (o3Max2 / 2);
  }

  draw(Canvas canvas, Size size) {
    // common
    var rand = Random();

    // pos (pendulum)
    bobX = originX + lineLength * sin(angle);
    bobY = originY + lineLength * cos(angle);

    var g = 0.8;
    aAcc = (-1 * g / lineLength) * sin(angle);

    if (rand.nextDouble() < 0.002) {
      aAcc += (-1 * g / lineLength) * sin(10 * pi / 180);
    }

    aVel += aAcc;
    aVel *= damping;
    angle += aVel;

    // type a
    if (currentType == _FireFlyType.A && nextType == null) {
      o1 = 0;

      if (rand.nextDouble() < 0.5) {
        nextType = _FireFlyType.B;
        targetTwinkCount = 1 + rand.nextInt(3);
        currTwinkCount = 0;
      }
    }

    // type b
    if (currentType == _FireFlyType.B && nextType == null) {
      o1 = 1;

      if (rand.nextDouble() < 0.5) {
        nextType = _FireFlyType.A;
      } else if (rand.nextDouble() < 0.63) {
        o2 = 0;
        o3 = 0;

        nextType = _FireFlyType.C;
      }
    }

    // type a, b 轉換
    if (
      (currentType == _FireFlyType.A && nextType == _FireFlyType.B) ||
      (currentType == _FireFlyType.B && nextType == _FireFlyType.A)
    ) {
      theta += frequency;

      if (theta > pi * 2) {
        theta %= pi * 2;
      }

      o1  = 0.5 - 0.5 * cos(theta);

      if (o1 >= 0.99) {
        currTwinkCount++;

        if (currTwinkCount == targetTwinkCount) {
          currentType = _FireFlyType.B;
          nextType = null;
        }
      } else if (o1 <= 0.01) {
        currentType = _FireFlyType.A;
        nextType = _FireFlyType.B;
      }
    }

    // c
    if (currentType == _FireFlyType.C && nextType == null) {
      o2 = 1;

      if (rand.nextDouble() < 0.2) {
        nextType = _FireFlyType.B;
      } else if (rand.nextDouble() < 0.5) {
        nextType = _FireFlyType.E;
      }
    }

    // c to b
    if (currentType == _FireFlyType.C && nextType == _FireFlyType.B) {
      o2 -= o2Vel;
      o2 = o2.clamp(0.0, 1.0);

      o3 -= o3Vel;
      o3 = o3.clamp(0.0, o3Max);

      if (o2 == 0.0 && o3 == 0.0) {
        currentType = _FireFlyType.B;
        nextType = null;
      }
    }

    // b to c
    if (currentType == _FireFlyType.B && nextType == _FireFlyType.C) {
      o2 += o2Vel;
      o2 = o2.clamp(0.0, 1.0);

      o3 += o3Vel;
      o3 = o3.clamp(0.0, o3Max);

      if (o2 == 1.0 && o3 == o3Max) {
        currentType = _FireFlyType.C;
        nextType = null;
      }
    }

    if (currentType == _FireFlyType.C && nextType == _FireFlyType.E) {
      o3 += o3Vel2;
      o3 = o3.clamp(o3Max, o3Max2);

      if (o3 == o3Max2) {
        currentType = _FireFlyType.E;
        nextType = null;
      }
    }

    if (currentType == _FireFlyType.E && nextType == _FireFlyType.C) {
      o3 -= o3Vel2;
      o3 = o3.clamp(o3Max, o3Max2);

      if (o3 == o3Max) {
        currentType = _FireFlyType.C;
        nextType = null;
      }
    }

    if (currentType == _FireFlyType.E && nextType == null) {
      if (rand.nextDouble() < 0.9) {
        nextType = _FireFlyType.C;
      }
    }

//    if (currentType == _FireFlyType.C && nextType == _FireFlyType.D) {
//
//    }
//
//    if (currentType == _FireFlyType.D && nextType == _FireFlyType.C) {
//
//    }
//
//    if (currentType == _FireFlyType.D && nextType == null) {
//
//    }

    // var

    if (currentType != _FireFlyType.A && currentType != _FireFlyType.B) {
      o1 = 1;
    }

    // draw

    // draw: 藍光
    if (o3 > 0.0) {
      for (int i = 0; i < 3; i++) {
        canvas.drawCircle(
            Offset(
              bobX,
              bobY,
            ),
            size.shortestSide * 0.132 * (o3 / o3Max2) * ((i + 1) / 3),
            Paint()
              ..color = Color(0xFF51D4FB).withOpacity(0.5)
              ..maskFilter = MaskFilter.blur(
                  BlurStyle.normal,
                  o3
              )
        );
      }
    }

    canvas.drawCircle(
        Offset(
          bobX,
          bobY,
        ),
        size.shortestSide * 0.032,
        Paint()
          ..color = Color(0xFF51D4FB).withOpacity(o1 * 0.7)
//          ..maskFilter = MaskFilter.blur(
//              BlurStyle.normal,
//              2
//          )
    );

    canvas.drawCircle(
        Offset(
          bobX,
          bobY,
        ),
        size.shortestSide * 0.025,
        Paint()
          ..color = Colors.white.withOpacity(o2)
    );
  }
}