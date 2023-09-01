import 'package:flutter/material.dart';

Widget button({Function? onPressed, String? text, Widget? page, BuildContext? context}) {
  return TextButton(
    onPressed: () {
      if (onPressed != null) {
        onPressed();
      }
      if (page != null && context != null) {
        Navigator.push(context, MaterialPageRoute(
          builder: (ctx) => page
        ));
      }
    },
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(text ?? '')
    ),
  );
}

Widget title(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Text(text,
      style: TextStyle(fontSize: 23, color: Colors.blueGrey),
    ),
  );
}

Widget p(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Text(text,
      style: TextStyle(),
    ),
  );
}