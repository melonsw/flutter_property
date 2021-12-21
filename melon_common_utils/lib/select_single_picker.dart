import 'package:cloud/model/select_data.dart';
import 'package:cloud/utils/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectSinglePicker extends StatelessWidget {
  SelectSinglePicker({
    Key key,
    this.pageName = "",
    this.dataList,
    this.changed,
  }) : super(key: key);

  final String pageName;
  final List<SelectModel> dataList;
  final ValueChanged<SelectModel> changed;
  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: 343,
        height: 289,
        child: Column(
          children: [
            Container(
              height: 52,
              padding: EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "请选择",
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorUtil.txtText,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.clear,
                      size: 20,
                      color: ColorUtil.txtText57,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              ),
            ),
            Divider(height: 0.5),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: CupertinoPicker(
                  itemExtent: 40,
                  selectionOverlay: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: CupertinoColors.quaternarySystemFill,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  onSelectedItemChanged: (index) {
                    selectIndex = index;
                    print("滚动选择 " + index.toString());
                  },
                  children: getChildren(),
                ),
              ),
            ),
            Divider(height: 0.5),
            Container(
              height: 44,
              child: TextButton(
                onPressed: () {
                  if (changed != null) {
                    changed(dataList[selectIndex]);
                  }
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  "确定",
                  style: TextStyle(fontSize: 16),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(343, 44),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getChildren() {
    List<Widget> children = [];
    if (dataList != null && dataList.length > 0) {
      dataList.forEach((element) {
        children.add(
          Container(
            height: 40,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Text(
              element.valueName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: ColorUtil.txtText,
              ),
            ),
          ),
        );
      });
    }
    return children;
  }
}
