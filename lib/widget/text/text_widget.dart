import 'dart:ffi';

import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final String text;
  final String fontSize;

  const TextWidget(this.text, this.fontSize, {Key key}) : super(key: key);

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: widget.fontSize.toString();
      ),
    );
  }
}
