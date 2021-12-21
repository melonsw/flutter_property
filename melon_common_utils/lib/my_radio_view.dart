import 'package:flutter/material.dart';

class MyRadioView<T> extends StatelessWidget {
  MyRadioView({
    Key key,
    this.value,
    this.groupValue,
    this.onChanged,
    this.content,
    this.iconSize = 20,
    this.paddingSize = 5,
    this.textSize = 14,
    this.textColor = const Color(0xFF1F1F1F),
  }) : super(key: key);

  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String content;
  final double iconSize;
  final double paddingSize;
  final double textSize;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          onChanged(value);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              groupValue == value
                  ? Icons.radio_button_on
                  : Icons.radio_button_off,
              color: groupValue == value ? Colors.blue : Colors.grey,
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
