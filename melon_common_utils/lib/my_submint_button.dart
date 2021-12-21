import 'package:cloud/utils/color_util.dart';
import 'package:flutter/material.dart';

class MySubmitButton extends StatelessWidget {
  MySubmitButton({
    Key key,
    this.content = "",
    this.backgroundColor = ColorUtil.blue2,
    this.onPressed,
    this.margin =
        const EdgeInsets.only(left: 16, top: 44, right: 16, bottom: 44),
  }) : super(key: key);

  final String content;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: onPressed != null ? onPressed : () {},
        child: Text(
          content == null ? "保存" : content,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            backgroundColor == null ? ColorUtil.blue2 : backgroundColor,
          ),
          minimumSize: MaterialStateProperty.all(
            Size(double.infinity, 45),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
