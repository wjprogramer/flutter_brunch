import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_brunch/shared/assets_path.dart';
import 'package:flutter_brunch/shared/custom_paint_container.dart';

import 'ff.dart';
import 'ff_51.dart';
import 'pos.dart';

class FireFlyDemo5 extends StatefulWidget {
  @override
  _FireFlyDemo5State createState() => _FireFlyDemo5State();
}

class _FireFlyDemo5State extends State<FireFlyDemo5> with TickerProviderStateMixin {

  late FF51 ff51;

  late AnimationController controller;
  late Size size;
  bool isInit = false;

  Color color1 = Color(0xFF51D4FB);

  late List<_BgLine> bgLines;
  late List<_LineFirefly> fgLines;
  late List<_BgFireFly> bgFireflies;
  late List<FireFly5> fireflies;

  /// Background: Cave Wall
  _caveWall(double w, double h) {
    return Center(
        child: ClipRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
                sigmaY: 5,
                sigmaX: 5
            ),
            child: Container(
              width: w,
              height: h,
              child: Image.asset(
                AssetsPath.CAVE_WALL3,
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
    );
  }

  /// Foreground
  _blackFg(canvas, size) {

//    ///
//    var path2 = Path()
//      ..moveTo(size.width, 0)
//      ..lineTo(0, 0)
//      ..lineTo(size.width * (383 / 1920), size.height * (195 / 1080))
//      ..lineTo(size.width * (575 / 1920), size.height * (173 / 1080))
//      ..lineTo(size.width * (715 / 1920), size.height * (171 / 1080))
//      ..lineTo(size.width * (720 / 1920), size.height * (138 / 1080))
//      ..lineTo(size.width * (776 / 1920), size.height * (143 / 1080))
//      ..lineTo(size.width * (818 / 1920), size.height * (170 / 1080))
//      ..lineTo(size.width * (898 / 1920), size.height * (170 / 1080))
//      ..lineTo(size.width * (971 / 1920), size.height * (148 / 1080))
//      ..lineTo(size.width * (1146 / 1920), size.height * (274 / 1080))
//      ..lineTo(size.width * (1279 / 1920), size.height * (238 / 1080))
//      ..lineTo(size.width * (1300 / 1920), size.height * (150 / 1080)) // 隱藏點
//      ..lineTo(size.width * (1478 / 1920), size.height * (154 / 1080))
//      ..lineTo(size.width * (1530 / 1920), size.height * (240 / 1080))
//      ..lineTo(size.width * (1676 / 1920), size.height * (214 / 1080));
//
//    canvas.drawPath(
//        path2,
//        Paint()
//          ..color = Color(0xFF453e24)
//    );
//
//    ///
//    var path1 = Path()
//      ..moveTo(size.width, 0)
//      ..lineTo(0, 0)
//      ..lineTo(size.width * (621 / 1920), size.height * (21 / 1080))
//      ..lineTo(size.width * (1000 / 1920), size.height * (104 / 1080))
//      ..lineTo(size.width * (1448 / 1920), size.height * (148 / 1080))
//      ..lineTo(size.width * (1573 / 1920), size.height * (121 / 1080));
//
//    canvas.drawPath(
//      path1,
//      Paint()
//        ..color = Color(0xFF1a1a1a)
//    );

    ///
    var path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.height * (579 / 1080))
      ..quadraticBezierTo(
        size.width * (40 / 1920), size.height * (500 / 1080),
        size.width * (161 / 1920), size.height * (449 / 1080),
      )
//                  ..lineTo(size.width * (161 / 1920), size.height * (449 / 1080))
      ..quadraticBezierTo(
        size.width * (180 / 1920), size.height * (400 / 1080), // in
        size.width * (294 / 1920), size.height * (175 / 1080),
      )
//                  ..lineTo(size.width * (294 / 1920), size.height * (175 / 1080))
      ..lineTo(size.width * (518 / 1920), size.height * (59 / 1080))
      ..lineTo(size.width * (586 / 1920), size.height * (55 / 1080))
      ..lineTo(size.width * (782 / 1920), size.height * (34 / 1080))
      ..lineTo(size.width * (892 / 1920), size.height * (38 / 1080))
      ..lineTo(size.width * (973 / 1920), size.height * (73 / 1080))
      ..quadraticBezierTo(
          size.width * (1261 / 1920), size.height * (241 / 1080),
          size.width * (1398 / 1920), size.height * (158 / 1080)
      )
//                  ..lineTo(size.width * (1261 / 1920), size.height * (241 / 1080))
//                  ..lineTo(size.width * (1398 / 1920), size.height * (158 / 1080))
      ..quadraticBezierTo(
          size.width * (1450 / 1920), size.height * (130 / 1080), // in
          size.width * (1496 / 1920), size.height * (116 / 1080)
      )
//                  ..lineTo(size.width * (1496 / 1920), size.height * (116 / 1080))
      ..lineTo(size.width * (1605 / 1920), size.height * (108 / 1080)) // 原x: 1625
      ..lineTo(size.width * (1654 / 1920), size.height * (75 / 1080))
      ..lineTo(size.width * (1713 / 1920), size.height * (96 / 1080))
      ..lineTo(size.width * (1685 / 1920), size.height * (157 / 1080))
      ..quadraticBezierTo(
          size.width * (1700 / 1920), size.height * (300 / 1080), // in
          size.width * (1811 / 1920), size.height * (469 / 1080)
      )
//                  ..lineTo(size.width * (1811 / 1920), size.height * (469 / 1080))
      ..lineTo(size.width * (1920 / 1920), size.height * (537 / 1080));

    canvas.drawPath(path, Paint());
  }

  /// 背景淺藍聚集的
  _fireFlyClusterBg(Canvas canvas, Size size) {

    var paint = Paint()
      ..color = Color(0xFF5488ff)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0)
    ;

    var paint2 = Paint()
      ..color = Color(0xFF5488ff)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, size.width * 0.02)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04
    ;

    /// 1
    Path path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(size.width * (250 / 1920), size.height * (300 / 1080))
      ..lineTo(size.width * (350 / 1920), size.height * (100 / 1080))
      ..lineTo(size.width * (900 / 1920), size.height * (50 / 1080))
      ..lineTo(size.width * (1800 / 1920), size.height * (150 / 1080))
    ;

    canvas.drawPath(
      path,
      paint
    );

    /// 2 效果不好
//    Path path2 = Path()
//      ..moveTo(size.width * (1400 / 1920), size.height * (250 / 1080))
//      ..lineTo(size.width * (1600 / 1920), size.height * (600 / 1080))
//      ..lineTo(size.width * (1900 / 1920), size.height * (700 / 1080))
//    ;

//    canvas.drawPath(
//        path2,
//        paint2
//    );

//    canvas.drawPath(
//        path2,
//        paint2..maskFilter = MaskFilter.blur(BlurStyle.normal, 4)
//    );
//
//    canvas.drawPath(
//        path2,
//        paint2..maskFilter = MaskFilter.blur(BlurStyle.normal, 10)
//    );

    /// 3
//    bgFireflies.forEach((e) { e.draw(canvas, size); });

    /// 4 改善或許可以?
    canvas.saveLayer(Offset.zero & size, Paint());

    Path path2 = Path()
      ..moveTo(size.width * (1450 / 1920), size.height * (220 / 1080))
      ..lineTo(size.width * (1460 / 1920), size.height * (240 / 1080))
      ..lineTo(size.width * (1420 / 1920), size.height * (280 / 1080))
      ..lineTo(size.width * (1430 / 1920), size.height * (290 / 1080))
      ..lineTo(size.width * (1440 / 1920), size.height * (300 / 1080))
      ..lineTo(size.width * (1450 / 1920), size.height * (310 / 1080))
      ..lineTo(size.width * (1500 / 1920), size.height * (330 / 1080))
      ..lineTo(size.width * (1510 / 1920), size.height * (350 / 1080))
      ..lineTo(size.width * (1540 / 1920), size.height * (380 / 1080))
      ..lineTo(size.width * (1560 / 1920), size.height * (380 / 1080))
      ..lineTo(size.width * (1480 / 1920), size.height * (430 / 1080))
      ..lineTo(size.width * (1485 / 1920), size.height * (460 / 1080))
      ..lineTo(size.width * (1530 / 1920), size.height * (450 / 1080))
      ..lineTo(size.width * (1525 / 1920), size.height * (440 / 1080))
      ..lineTo(size.width * (1515 / 1920), size.height * (430 / 1080))
      ..lineTo(size.width * (1555 / 1920), size.height * (430 / 1080))
      ..lineTo(size.width * (1580 / 1920), size.height * (480 / 1080))
      ..lineTo(size.width * (1640 / 1920), size.height * (560 / 1080))
      ..lineTo(size.width * (1900 / 1920), size.height * (700 / 1080))
    ;

    Path path3 = Path()
      ..moveTo(size.width * (1450 / 1920), size.height * (220 / 1080))
      ..lineTo(size.width * (1460 / 1920), size.height * (240 / 1080))
      ..lineTo(size.width * (1420 / 1920), size.height * (280 / 1080))
      ..lineTo(size.width * (1430 / 1920), size.height * (290 / 1080))
      ..lineTo(size.width * (1440 / 1920), size.height * (300 / 1080))
      ..lineTo(size.width * (1450 / 1920), size.height * (310 / 1080))
      ..lineTo(size.width * (1500 / 1920), size.height * (330 / 1080))
      ..lineTo(size.width * (1510 / 1920), size.height * (350 / 1080))
      ..lineTo(size.width * (1540 / 1920), size.height * (380 / 1080))
      ..lineTo(size.width * (1560 / 1920), size.height * (380 / 1080))
      ..lineTo(size.width * (1480 / 1920), size.height * (430 / 1080))
      ..lineTo(size.width * (1485 / 1920), size.height * (460 / 1080))
      ..lineTo(size.width * (1530 / 1920), size.height * (450 / 1080))
      ..lineTo(size.width * (1525 / 1920), size.height * (440 / 1080))
      ..lineTo(size.width * (1515 / 1920), size.height * (430 / 1080))
      ..lineTo(size.width * (1555 / 1920), size.height * (430 / 1080))
      ..lineTo(size.width * (1580 / 1920), size.height * (480 / 1080))
      ..lineTo(size.width * (1640 / 1920), size.height * (560 / 1080))
      ..lineTo(size.width * (1900 / 1920), size.height * (700 / 1080))

      ..lineTo(size.width * (1920 / 1920), size.height * (700 / 1080))
      ..lineTo(size.width * (1920 / 1920), size.height * (1080 / 1080))
      ..lineTo(size.width * (0 / 1920), size.height * (1080 / 1080))
      ..lineTo(size.width * (0 / 1920), size.height * (0 / 1080))
    ;

//    canvas.clipPath(
//        path3,
//    );
//
//    canvas.drawPath(
//        path2,
//        paint2
//    );

    canvas.restore();
  }

  ///
  _fireFlyFg(Canvas canvas, Size size) {

    // 1.
//    var xs = [320, 340, 300, 320, 320];
//    var ys = [180, 200, 180, 180, 180];
//
//    for (int i = 0; i < xs.length; i++) {
//      canvas.drawCircle(
//          Offset(
//            size.width * (xs[i] / 1920),
//            size.height * (ys[i] / 1080),
//          ),
//          size.shortestSide * 0.032,
//          Paint()
//            ..color = color1
//            ..maskFilter = MaskFilter.blur(
//                BlurStyle.normal,
//                5
//            )
//      );
//    }
//
//    canvas.drawCircle(
//        Offset(
//          size.width * (320 / 1920),
//          size.height * (180 / 1080),
//        ),
//        size.shortestSide * 0.025,
//        Paint()
//          ..color = Colors.white
//    );

    // 2.
    fireflies.forEach((e) {
      e.draw(canvas, size);
    });
  }

  ///
  _linesBg(Canvas canvas, Size size) {
    bgLines.forEach((e) { e.draw(canvas, size); });
  }

  ///
  _linesFg(Canvas canvas, Size size) {
    fgLines.forEach((e) { e.draw(canvas, size); });
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1000)
    )
      ..addListener(() {
        setState(() {

        });
      })
      ..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    double w;
    double h;

    w = size.width;
    h = w * (1080 / 1920);

    if (!isInit) {
      _initFgLines(w, h);
      _initBgLines(w, h);
      _initFireflies(w, h);
      _initBgFireflies(w, h);

      ff51 = FF51(w, h);

      isInit = true;
    }

    return Scaffold(
      body: Center(
        child: ClipRect(
          child: Container(
            width: w,
            height: h,
            child: Stack(
              children: <Widget>[
                _caveWall(w, h),
                Center(
                  child: Container(
                    width: w,
                    height: h,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
                ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaY: 5,
                    sigmaX: 5
                  ),
                  child: CustomPaintContainer2(
                    color: Colors.transparent,
                    height: h,
                    width: w,
                    canvasPaint: (canvas, size) {
                      _fireFlyClusterBg(canvas, size);
                    }
                  ),
                ),
                ImageFiltered(
                  imageFilter: ImageFilter.blur(
                      sigmaY: 0,
                      sigmaX: 1
                  ),
                  child: CustomPaintContainer2(
                      color: Colors.transparent,
                      height: h,
                      width: w,
                      canvasPaint: (canvas, size) {
                        _fireFlyFg(canvas, size);
                      }
                  ),
                ),
                CustomPaintContainer2(
                  color: Colors.transparent,
                  height: h,
                  width: w,
                  canvasPaint: (canvas, size) {
                    _linesBg(canvas, size);
//                    _fireFlyFg(canvas, size);
                    _linesFg(canvas, size);
                    ff51.draw(canvas, size);
                    _blackFg(canvas, size);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _initFgLines(double w, double h) {
    var xs = <double>[391, 655, 679, 724  , 1414, 1657, 1828];
    var ys = <double>[716, 956, 994, 1044 ,  851,  701,  970];

    fgLines = List.generate(xs.length, (index) => _LineFirefly(
        originX: w * (xs[index] / 1920),
        lineLength: h * (ys[index] / 1080))
    );
  }

  _initBgLines (double w, double h) {
    Random rand = Random();

    bgLines = List.generate(30, (index) {
      double x = rand.nextDouble() * 300 + 200;
      double y = rand.nextDouble() * 500 + 50;

      return _BgLine(
          centerX: w * (x / 1920),
          height: h * (y / 1080)
      );
    });

    bgLines.addAll(List.generate(30, (index) {
      double x = rand.nextDouble() * 596 + 900;
      double y = rand.nextDouble() * 500 + 50;

      return _BgLine(
          centerX: w * (x / 1920),
          height: h * (y / 1080)
      );
    }));
  }

  _initFireflies(double w, double h) {
    var rand = Random();

    fireflies = List.generate(50, (index) {

//      // x 介於 300 至 1920
//      var x = 300 + (rand.nextDouble() * 1620);
//
//      // y根據x計算：
//      // 基礎值介於 433 至 605，在基礎值等於433時，y值範圍在433正負500；基礎值等於 605 時，y值範圍在605正負200
//      // 基礎值及正負範圍值根據x在最大最小值的比例
//      var ratio = ((x - 300) / 1620);
//      var range = 200 + 300 * ratio;
//      var base = 433 + 172 * ratio;
//      var y = base - range + (range * 2 * rand.nextDouble());

      var x = rand.nextDouble() * 1920;
      var y = rand.nextDouble() * 1080;

      return FireFly5(
          originX: w * (x / 1920),
          lineLength: h * (y / 1080)
      );
    });
  }

  _initBgFireflies(double w, double h) {
    var xys = [
//      Pos(500, 500),
//      Pos(500, 500),
//      Pos(1400, 250),
//      Pos(1410, 250),
//      Pos(1420, 250),
//      Pos(1430, 250),
//      Pos(1450, 380),
//      Pos(1470, 480),
//      Pos(1490, 480),
//      Pos(1520, 500),
//      Pos(1540, 500),
//      Pos(1560, 500),
//      Pos(1570, 520),
//      Pos(1580, 550),
//      Pos(1590, 570),
//      Pos(1600, 600),
//      Pos(1630, 620),
//      Pos(1650, 640),
//      Pos(1680, 645),
//      Pos(1690, 650),
//      Pos(1720, 650),
//      Pos(1740, 640),
//      Pos(1760, 660),
//      Pos(1780, 660),
//      Pos(1790, 660),
//      Pos(1800, 680),
//      Pos(1820, 690),
//      Pos(1840, 700),
//      Pos(1860, 700),
//      Pos(1880, 690),
//      Pos(1900, 700),
      Pos(560, 1080),
      Pos(580, 990),
      Pos(500, 500),
      Pos(500, 500),
      Pos(500, 500),
    ];

    bgFireflies = xys.map((e) => _BgFireFly(
      x: w * (e.x / 1920),
      y: h * (e.y / 1080),
      color: Color(0xFF5488ff),
    )).toList();
  }
}

/// 螢火蟲
class _BgFireFly {
  late double x;
  late double y;

  late double radius;
  late double frequency;
  late double theta;
  late double opacity;

  double luminousMaxFrequency = pi / 100;
  double luminousMinFrequency = pi / 300;

  Color color;

  _BgFireFly({
    required this.x,
    required this.y,
    required this.color,
  }) {
    var rand = Random();

    frequency = rand.nextDouble() * (luminousMaxFrequency - luminousMinFrequency) + luminousMinFrequency;
    theta = pi * 2 * rand.nextDouble();
    opacity = 0.5 + 0.3 * sin(theta);
    radius = 2 + 5 * rand.nextDouble();
  }

  draw(Canvas canvas, Size size) {
    theta += frequency;
    opacity  = 0.5 - 0.5 * cos(theta);

    if (theta > pi * 2) {
      theta %= pi * 2;
    }

    canvas.drawCircle(
        Offset(
          x,
          y,
        ),
        radius,
        Paint()
          ..color = color
//          ..maskFilter = MaskFilter.blur(
//              BlurStyle.normal,
//              2
//          )
    );
  }
}

/// 背景中的線條（較模糊、不會移動）
class _BgLine {
  double centerX;
  double height;

  _BgLine({
    required this.centerX,
    required this.height,
  });

  draw(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(centerX, 0),
        Offset(centerX, height),
        Paint()
          ..shader = LinearGradient(
            colors: [
              Color(0xFF51D4FB),
              Colors.grey,
            ],
            stops: [
              0.4,
              0.9,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromLTWH(0, 0, size.width, height))
          ..strokeWidth = size.shortestSide * 0.002
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 2.0)
    );
  }
}

/// deprecated（來自 ff_2.dart 改自草的飄動）
class _FgLine {
  late double centerX;
  late double lineLength;
  double width = 2.0;
  late double bottom;

  double shakingFrequency = pi / 1000;
  double maxShakingRate = 0.2;

  late double theta;

  _FgLine({
    required this.centerX,
    required this.lineLength,
  }) {
    var rand = Random();

    theta = pi * 2 * rand.nextDouble();
    bottom = lineLength;
  }

  draw(Canvas canvas, Size size) {
    ///
    double dx = sin(theta) * lineLength * maxShakingRate;

//    Path path = Path()
//      ..moveTo(centerX - width / 2, 0)
//      ..quadraticBezierTo(
//          centerX - dx / 2,
//          lineLength / 2,
//          centerX + width / 2 + dx,
//          lineLength / 3
//      )
//      ..quadraticBezierTo(
//          centerX + width / 2 - dx / 2,
//          lineLength / 2,
//          centerX + width / 2,
//          0
//      );

    Path path = Path()
      ..moveTo(centerX - width / 2, 0)
      ..quadraticBezierTo(
          centerX, //  - dx / 2
          lineLength / 2,
          centerX + width / 2 , // + dx
          lineLength / 3
      )
      ..quadraticBezierTo(
          centerX + width / 2, // - dx / 2
          lineLength / 2,
          centerX + width / 2,
          0
      );

    canvas.drawPath(
        path,
        Paint()
          ..shader = LinearGradient(
            colors: [
              Color(0xFF51D4FB),
              Colors.grey,
            ],
            stops: [
              0.0,
              0.3,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromLTWH(0, 0, size.width, lineLength))
          ..strokeWidth = size.shortestSide * 0.002
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1.0)
    );

    this.theta += this.shakingFrequency;
  }
}

/// 線與螢火蟲 (也可以只有線)
///
/// 處於前景，單擺運動
class _LineFirefly {
  late double centerX;
  late double lineLength;

  late double originX;
  late double originY = 0;
  late double bobX;
  late double bobY;

  late double angle;
  late double aVel = 0.0;
  late double aAcc = 0.0;

  late double damping = 0.995;

  /// [originX]、[lineLength]是經過轉化後的數字
  _LineFirefly({
    required this.originX,
    required this.lineLength,
  }) {
    var rand = Random();

    angle = rand.nextBool() ? pi / (40 + 8 * rand.nextDouble()) : pi / (-40 - 8 * rand.nextDouble());
  }

  draw(Canvas canvas, Size size) {
    var rand = Random();

    bobX = originX + lineLength * sin(angle);
    bobY = originY + lineLength * cos(angle);

    var g = 0.8;
    aAcc = (-1 * g / lineLength) * sin(angle);

    if (rand.nextDouble() < 0.005) {
      aAcc = (-1 * g / lineLength) * sin(90 * rand.nextDouble());
    }

    aVel += aAcc;
    aVel *= damping;
    angle += aVel;

    canvas.drawLine(
        Offset(originX, originY),
        Offset(bobX, bobY),
        Paint()
          ..shader = LinearGradient(
            colors: [
              Color(0xFF51D4FB),
              Colors.grey,
            ],
            stops: [
              0.0,
              0.3,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromLTWH(0, 0, size.width, lineLength))
          ..strokeWidth = size.shortestSide * 0.002
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1.0)
    );
  }
}