import 'dart:io';

import 'package:cloud/utils/color_util.dart';
import 'package:cloud/utils/resources_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:path_provider/path_provider.dart';

class MyUpdateDialog extends StatefulWidget {
  final String force;
  final String version;
  final String content;
  final String apkUrl;

  MyUpdateDialog({
    Key key,
    this.force = "0",
    this.version = "1.1.0",
    this.content = "优化了使用体验",
    this.apkUrl =
        "https://yun.bolink.club/parkandroid/update_tpns/apk/bolink_manager.apk",
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyUpdateDialogState();
  }
}

class MyUpdateDialogState extends State<MyUpdateDialog> {
  double progress = -1.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Container(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 320,
              height: 207,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ResourcesUtil.bg_update_top,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              padding: EdgeInsets.only(bottom: 3),
              alignment: Alignment.bottomCenter,
              child: Text(
                "发现新版本V" + widget.version,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF1476FE),
                ),
              ),
            ),
            Container(
              width: 320,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 16, top: 5, right: 16, bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "升级功能:\n" + widget.content,
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorUtil.txtText,
                        height: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 19),
                  Visibility(
                    visible: progress < 0,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (widget.force == "1") {
                                print("强制更新");
                              } else {
                                Navigator.of(context).pop(false);
                              }
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                Size(144, 44),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: widget.force == "1"
                                        ? ColorUtil.txtLine
                                        : ColorUtil.txtText4E,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: Text(
                              "残忍拒绝",
                              style: TextStyle(
                                fontSize: 16,
                                color: widget.force == "1"
                                    ? ColorUtil.txtLine
                                    : ColorUtil.txtText4E,
                              ),
                            ),
                          ),
                        ),
                        Container(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                progress = 0.0;
                              });
                              _downLoadApk(widget.apkUrl);
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                Size(144, 44),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(ColorUtil.blue2),
                            ),
                            child: Text(
                              "立即升级",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: progress >= 0,
                    child: _NumberProgress(
                      value: progress,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _downLoadApk(String apkUrl) async {
    // 获取外部存储目录 用户可见
    try {
      Directory directory = await getExternalStorageDirectory();
      print(directory.path);
      String apkPath = directory.path + "/物管云坐席.apk";
      File apkFile = File(apkPath);
      if (apkFile.existsSync()) {
        apkFile.deleteSync();
      }
      await Dio().download(
        apkUrl,
        apkPath,
        onReceiveProgress: (count, total) {
          ///当前下载的百分比例
          progress = NumUtil.getNumByValueDouble((count / total), 2);
          print(progress);
          if (count == total) {
            print('下载完成');
            Navigator.of(context).pop(false);
            progress = 0.0;
            InstallPlugin.installApk(apkPath, "com.bolink.cloud").then((value) {
              print('install apk $value');
            }).catchError((error) {
              print('install apk error: $error');
            });
          } else {
            setState(() {});
          }
          // print((count / total * 100).toStringAsFixed(0) + "%");
          // update(progress) 进度 0-1
        },
      );
    } catch (e) {
      print("下载安装包出错  " + e.toString());
      setState(() {
        progress = -1.0;
      });
    }
  }
}

/// 带进度文字的圆角进度条
class _NumberProgress extends StatelessWidget {
  /// 进度条的高度
  final double height;

  /// 进度
  final double value;

  /// 进度条的背景颜色
  final Color backgroundColor;

  /// 进度条的色值
  final Color valueColor;

  /// 文字的颜色
  final Color textColor;

  /// 文字的大小
  final double textSize;

  /// 文字的对齐方式
  final AlignmentGeometry textAlignment;

  /// 边距
  final EdgeInsetsGeometry padding;

  _NumberProgress(
      {Key key,
      this.height = 10.0,
      this.value = 0.0,
      this.backgroundColor = const Color(0x5A1677FF),
      this.valueColor = Colors.blue,
      this.textColor = Colors.white,
      this.textSize = 8.0,
      this.padding = EdgeInsets.zero,
      this.textAlignment = Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              height: height,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(height)),
                child: LinearProgressIndicator(
                  value: value,
                  backgroundColor: backgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(valueColor),
                ),
              ),
            ),
            Container(
              height: height,
              alignment: textAlignment,
              child: Text(
                value >= 1 ? '100%' : '${(value * 100).toInt()}%',
                style: TextStyle(
                  color: textColor,
                  fontSize: textSize,
                ),
              ),
            ),
          ],
        ));
  }
}
