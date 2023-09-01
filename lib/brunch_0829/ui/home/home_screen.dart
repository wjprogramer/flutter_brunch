import 'package:flutter/material.dart';
import 'package:flutter_brunch/brunch_0829/const.dart';
import 'package:flutter_brunch/brunch_0829/ui/home/component/shimmer.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
        } else if (status == AnimationStatus.completed) {}
      });

    _opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(Wording.homePageName),
      ),
      body: Center(
        child: Container(
          color: Colors.blue[400],
          padding: const EdgeInsets.all(16.0),
          child: Shimmer.fromColors(
            child: Text('Shimmer', style: TextStyle(fontSize: 30),),
            baseColor: Colors.black12,
            highlightColor: Colors.white,
            loop: 99,
          ),
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(color: Colors.cyanAccent, fontSize: 18),
      ),
    );
  }

  Widget _introduction() {
    var baseColor = Color(0xFF6A8EC5);
    var highlightColor = Color(0xFF9db2d1);

    return Container(
      margin: const EdgeInsets.all(24),
      child: Wrap(
        children: [
          _title('App Introduction'),
          Container(
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  baseColor,
                  baseColor,
                  highlightColor,
                  baseColor,
                  baseColor
                ],
                stops: [
                  0.0,
                  0.35 * _controller.value, //+ 0.65 * _controller.value,
                  0.5  * _controller.value, //+ 0.5 * _controller.value,
                  0.65 * _controller.value, //+ 0.35 * _controller.value,
                  1.0
                ],
              ),
            ),
            child: Center(
              child: Text(
                '這是一個，用於展示 每次 Flutter Brunch 現場 小挑戰內容的 App。',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
