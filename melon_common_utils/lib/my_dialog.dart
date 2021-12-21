import 'package:cloud/utils/color_util.dart';
import 'package:flutter/material.dart';

const double _defaultElevation = 24.0;

// 默认边距
const EdgeInsets _defaultInsetPadding =
    EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0);

// 默认圆角
const RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
);

class MyDialog extends StatelessWidget {
  const MyDialog({
    Key key,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.insetPadding = _defaultInsetPadding,
    this.shape,
    this.title,
    this.content,
    this.leftButton,
    this.rightButton,
    this.leftCallback,
    this.rightCallback,
  }) : super(key: key);

  final Color backgroundColor;
  final double elevation;
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final EdgeInsets insetPadding;
  final ShapeBorder shape;
  final String title;
  final String content;
  final String leftButton;
  final String rightButton;
  final VoidCallback leftCallback;
  final VoidCallback rightCallback;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: insetPadding,
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 343,
              maxHeight: 183,
            ),
            child: Material(
              color: backgroundColor ?? Colors.white,
              elevation: elevation ?? _defaultElevation,
              shape: shape ?? _defaultDialogShape,
              type: MaterialType.card,
              clipBehavior: Clip.none,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 24, top: 24, right: 24),
                      child: Text(
                        title == null || title.isEmpty ? "提示" : title,
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorUtil.txtText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 24, top: 24, right: 24),
                        child: Text(
                          content == null || content.isEmpty
                              ? "确认退出吗？"
                              : content,
                          style: TextStyle(
                            fontSize: 15,
                            color: ColorUtil.txtText57,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 0.5,
                            color: ColorUtil.txtLine,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: leftCallback != null
                                  ? leftCallback
                                  : () {
                                      Navigator.of(context).pop(false);
                                    },
                              child: Text(
                                leftButton == null || leftButton == ""
                                    ? "取消"
                                    : leftButton,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorUtil.txtText57,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                  Size(double.infinity, 44),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 44,
                            width: 0.5,
                            color: ColorUtil.txtLine,
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: rightCallback != null
                                  ? rightCallback
                                  : () {
                                      Navigator.of(context).pop(false);
                                    },
                              child: Text(
                                rightButton == null || rightButton == ""
                                    ? "确定"
                                    : rightButton,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorUtil.blue2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                  Size(double.infinity, 44),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
