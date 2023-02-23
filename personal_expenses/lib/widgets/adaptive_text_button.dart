import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final VoidCallback pressHandler;

  const AdaptiveTextButton(this.text, this.pressHandler, {super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontWeight: FontWeight.bold,
    );

    return Platform.isIOS
        ? CupertinoButton(
            onPressed: pressHandler,
            child: Text(
              text,
              style: textStyle,
            ),
          )
        : TextButton(
            onPressed: pressHandler,
            child: Text(
              text,
              style: textStyle,
            ),
          );
  }
}
