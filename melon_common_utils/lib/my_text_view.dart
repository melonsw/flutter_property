import 'package:cloud/utils/color_util.dart';
import 'package:cloud/utils/string_util.dart';
import 'package:flutter/material.dart';

class MyTextView extends StatelessWidget {
  MyTextView({
    Key key,
    this.content = "",
    this.textAlign,
    this.maxLines,
    this.fontColor = ColorUtil.txtText,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  final String content;
  final TextAlign textAlign;
  final int maxLines;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      StringUtil.getStringEmpty(content),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
