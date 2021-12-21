import 'package:cloud/model/select_data.dart';
import 'package:cloud/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SelectInputDataDialog extends StatefulWidget {
  SelectInputDataDialog({
    Key key,
    this.type = "月",
    this.pageName = "add",
    this.changed,
  }) : super(key: key);

  final String type;
  final String pageName;
  final ValueChanged<SelectModel> changed;

  @override
  State<StatefulWidget> createState() {
    return _SelectInputDataDialogState();
  }
}

class _SelectInputDataDialogState extends State<SelectInputDataDialog> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  List<SelectModel> rows = [];
  int selectIndex = -1;

  /// 周期
  getCycles() {
    String type = widget.type;
    String pageName = widget.pageName;
    rows = [
      SelectModel(
          valueNo: "1", valueName: "1" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "2", valueName: "2" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "3", valueName: "3" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "4", valueName: "4" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "5", valueName: "5" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "6", valueName: "6" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "7", valueName: "7" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "8", valueName: "8" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "9", valueName: "9" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "10", valueName: "10" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "11", valueName: "11" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "12", valueName: "12" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "24", valueName: "24" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "48", valueName: "48" + type.toString(), isSelect: false),
      SelectModel(
          valueNo: "60", valueName: "60" + type.toString(), isSelect: false),
    ];
    // if (pageName == "add") {
    //   rows.insert(
    //     0,
    //     SelectModel(
    //         valueNo: "0", valueName: "0" + type.toString(), isSelect: false),
    //   );
    // }
  }

  @override
  void initState() {
    super.initState();
    getCycles();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Container(
        width: 284,
        height: 340,
        child: Column(
          children: [
            Container(
              height: 52,
              padding: EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "购买周期",
                    style: TextStyle(fontSize: 16),
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
                  )
                ],
              ),
            ),
            Divider(height: 0.5),
            Container(
              height: 44,
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Text(
                    "自定义周期",
                    style: TextStyle(fontSize: 14),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[0-9]")),
                        LengthLimitingTextInputFormatter(3),
                      ],
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorUtil.txtText,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "请选择或输入周期",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: ColorUtil.txtHint,
                        ),
                      ),
                      onChanged: (value) {
                        if (value.startsWith("0")) {
                          _controller.text = "";
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (_focusNode.hasFocus) {
                        _focusNode.unfocus();
                      }
                      rows.forEach((element) {
                        element.isSelect = false;
                      });
                      setState(() {
                        selectIndex = index;
                        if (rows[selectIndex].valueNo != "0") {
                          _controller.text =
                              rows[selectIndex].valueNo.toString();
                        }
                        rows[selectIndex].isSelect = true;
                      });
                      // onClick(index);
                    },
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 45,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${rows[index].valueName}',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorUtil.txtText,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            rows[index].isSelect
                                ? Icons.radio_button_on
                                : Icons.radio_button_off,
                            size: 20,
                            color: rows[index].isSelect
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 1,
                  );
                },
                itemCount: rows.length,
              ),
            ),
            Divider(height: 0.5),
            Container(
              height: 44,
              child: TextButton(
                onPressed: () {
                  save();
                },
                child: Text("确定"),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(284, 44),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  save() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
    if (_controller.text.isEmpty && selectIndex == -1) {
      print("啥都没选，就这么退出呗");
    } else if (_controller.text.isNotEmpty) {
      if (int.tryParse(_controller.text) > 100) {
        EasyLoading.showToast("周期范围是 1~100");
        return;
      }
      SelectModel model = SelectModel(
        valueNo: _controller.text,
        valueName: _controller.text + widget.type.toString(),
      );
      if (widget.changed != null) {
        widget.changed(model);
      }
    } else {
      if (widget.changed != null) {
        widget.changed(rows[selectIndex]);
      }
    }

    Navigator.of(context).pop(true);
  }
}
