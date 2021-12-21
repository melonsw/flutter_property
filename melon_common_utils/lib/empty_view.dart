import 'package:cloud/utils/color_util.dart';
import 'package:flutter/material.dart';

class EmptyViewWidget extends StatelessWidget {
  EmptyViewWidget({
    Key key,
    this.imagePath = "",
    this.imageWidth = 185,
    this.imageHeight = 125,
    this.content = "",
  }) : super(key: key);

  final String imagePath;

  final double imageWidth;

  final double imageHeight;

  final String content;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 140),
            Image.asset(
              imagePath,
              width: imageWidth,
              height: imageHeight,
            ),
            Text(
              content,
              style: TextStyle(
                color: ColorUtil.txtText6,
                fontSize: 13.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
