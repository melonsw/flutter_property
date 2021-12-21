import 'package:flutter/material.dart';

class MyCheckView extends StatelessWidget {
  MyCheckView({
    Key key,
    this.value = false,
    this.content = "",
    this.iconSize = 20,
    this.paddingSize = 3,
    this.textSize = 14,
    this.textColor = const Color(0xFF1F1F1F),
    this.onCallback,
  }) : super(key: key);

  final bool value;
  final String content;
  final double iconSize;
  final double paddingSize;
  final double textSize;
  final Color textColor;
  final VoidCallback onCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onCallback,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              value
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
              color: value ? Colors.blue : Colors.grey,
              size: iconSize,
            ),
            Container(width: paddingSize),
            Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: textSize,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
