import 'dart:math';

import 'package:flutter/material.dart';

import 'pos.dart';

class FF51 {

  late double w;
  late double h;

  late double fireflyX;
  late double fireflyY;

  // 螢火蟲移動相關
  late double maxMoveRangeX;
  late double minMoveX;
  late double maxMoveX;
  late double minMoveY;
  late double maxMoveY;
  double? targetX;
  late double moveVelX;
  late double moveVelY;

  FF51(this.w, this.h) {
    fireflyX = w * (1700 / 1920);
    fireflyY = h * (100 / 1080);

    minMoveX = w * (1660 / 1920);
    maxMoveX = w * (1800 / 1920);
    maxMoveRangeX = w * (50 / 1920);
    minMoveY = w * 0.001;
    maxMoveY = w * 0.001;
    moveVelX = w * (4 / 1920);
    moveVelY = w * (1 / 1920);
  }

  var linePoss = [
    Pos(1600, 200),
    Pos(1620, 250),
    Pos(1640, 280),
    Pos(1650, 200),
    Pos(1670, 200),
    Pos(1680, 200),
    Pos(1700, 200),
  ];

  draw(Canvas canvas, Size size) {
    var w = size.width;
    var h = size.height;

    canvas.saveLayer(Offset.zero & size, Paint());

    /// region line
    linePoss.forEach((pos) {
      canvas.drawLine(
        Offset(w * (pos.x / 1920), h * (0 / 1080)),
        Offset(w * (pos.x / 1920), h * (pos.y / 1080)),
        Paint()
          ..shader = LinearGradient(
            colors: [
              Color(0xFF51D4FB),
              Colors.grey,
            ],
            stops: [
              0.5,
              0.9,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromLTWH(0, 0, size.width, h * (pos.y / 1080)))
          ..strokeWidth = size.shortestSide * 0.002
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1.0)
      );
    });
    /// endregion

    /// region 螢火蟲
    var rand = Random();

    if (targetX != null) {
      if (fireflyX < targetX!) {
        fireflyX += moveVelX;
        fireflyY += moveVelY;
      } else if (fireflyX > targetX!) {
        fireflyX -= moveVelX;
        fireflyY -= moveVelY;
      }

      if (fireflyX < targetX! + moveVelX && fireflyX > targetX! - moveVelX) {
        targetX = null;
      }

    } else if (targetX == null){
      if (rand.nextDouble() < 0.05) {
        targetX = rand.nextBool() ?  fireflyX - (maxMoveRangeX * rand.nextDouble()) : fireflyX + (maxMoveRangeX * rand.nextDouble());

        if (targetX! < minMoveX || targetX! > maxMoveX) {
          targetX = null;
        }
      }
    }

    for (int i = 0; i < 5; i++) {
      canvas.drawOval(
          Rect.fromCenter(
            center: Offset(fireflyX, fireflyY,),
            width: w * 0.017 * 4 * ((i + 1) / 5),
            height: w * 0.017 * 2
          ),
          Paint()
            ..color = Color(0xFF51D4FB).withOpacity(1 - ((i + 1) / 5) * 0.8)
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, w * 0.017)
      );
    }

    canvas.drawCircle(
        Offset(
          fireflyX,
          fireflyY,
        ),
        w * 0.007,
        Paint()
          ..color = Colors.white
    );
    /// endregion


    canvas.restore();
  }
}