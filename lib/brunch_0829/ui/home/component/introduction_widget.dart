import 'package:flutter/material.dart';

class IntroductionWidget extends StatelessWidget {
  const IntroductionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: Wrap(
        children: [
          Text(
            'App Introduction',
            style: TextStyle(color: Colors.cyanAccent, fontSize: 18),
          ),
          Container(
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                '這是一個，用於展示 每次 Flutter Brunch 現場 小挑戰內容的 App。',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
