import 'package:flutter/material.dart';
import 'package:flutter_brunch/brunch_0829/const.dart';
import 'package:flutter_brunch/brunch_0829/ui/home/component/shimmer.dart';

import 'component/introduction_widget.dart';

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
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                  child: Text(
                'Flutter Brunch Challenge',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              )),
            ),
            ListTile(
              leading: Icon(Icons.flag),
              title: Text('小挑戰們'),
            )
          ],
        ),
      ),
      backgroundColor: Colors.blue.shade900,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    _controller.forward(from: 0.0);
                  },
                  child: _introduction()),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: _title('Challenges'),
              ),
              //  https://flutter.dev/docs/cookbook/design/drawer
              Container(
                margin: const EdgeInsets.only(left: 24, right: 24, bottom: 18),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    'Flutter Brunch 2020/08 '
                    '\n 1. Widget 練習：Drawer'
                    '\n 2. 動畫練習：幫 App 介紹區塊加上動畫效果'
                    '\n 3. 點擊開啟 Drawer',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 24,),
              _openDrawerButton(),
              SizedBox(height: 24,),
              Container(
                color: Colors.blue[400],
                padding: const EdgeInsets.all(16.0),
                child: Shimmer.fromColors(
                  child: Text('Shimmer', style: TextStyle(fontSize: 30),),
                  baseColor: Colors.black12,
                  highlightColor: Colors.white,
                  loop: 99,
                ),
              ),
            ],
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

  // region 08/29

  Widget _openDrawerButton() {
    return TextButton(
      onPressed: () {
        _scaffoldKey.currentState?.openDrawer();
      },
      // shape: StadiumBorder(
      //   side: BorderSide(
      //     color: Colors.white,
      //   ),
      // ),
      child: Text(
        'Open Drawer',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

// endregion
}
