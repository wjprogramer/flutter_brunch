import 'package:flutter/material.dart';
import 'package:flutter_brunch/brunch_0829/const.dart';

import 'component/introduction_widget.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  AnimationController _controller;

  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )
      ..addListener(() {
        setState(() { });
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
              child: Text('Flutter Brunch Challenge', style: TextStyle(color: Colors.white, fontSize: 40,),),
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
                  _scaffoldKey.currentState.openDrawer();
                  _controller.forward(from: 0.0);
                },
                child: Opacity(opacity: _opacityAnimation.value, child: IntroductionWidget())
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Challenges',
                    style: TextStyle(color: Colors.cyanAccent, fontSize: 18),
                  ),
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
