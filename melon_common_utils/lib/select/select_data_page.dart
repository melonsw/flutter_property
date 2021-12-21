import 'package:cloud/http/api.dart';
import 'package:cloud/http/dio_manager.dart';
import 'package:cloud/model/select_data.dart';
import 'package:cloud/pagers/log/app_logutils.dart';
import 'package:cloud/routes/application.dart';
import 'package:cloud/routes/global.dart';
import 'package:cloud/utils/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectDataPage extends StatefulWidget {
  @override
  SelectDataPageState createState() => SelectDataPageState();
}

class SelectDataPageState extends State<SelectDataPage> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  String name = "";
  Map<String, dynamic> arguments = {};
  Map<String, dynamic> headers = {};
  List<SelectModel> rows = [];

  @override
  void initState() {
    super.initState();
    headers = {"tpnsToken": Global.login.token};
    Future.delayed(Duration.zero, () {
      switch (name) {
        case 'newqueryAll':
          // 获取车类型
          newqueryAll();
          break;
        case 'getParkChannels':
          // 获取通道
          getParkChannels();
          break;
        case 'zhouqi':
          // 购买周期
          getZhouqis();
          break;
        case 'bumen':
          // 所属部门
          getBumens();
          break;
        case 'chanpin':
          // 包月产品
          getChanpins();
          break;
        case 'address':
          // 区域
          getAddress();
          break;
        case 'getAllChannel':
          // 通道列表
          getAllChannel();
          break;
      }
    });
  }

  getAddress() {
    DioManager().post(
      Api.getComArea,
      arguments,
      headers,
      (response) {
        print(response.toString());
        if (response != null) {
          SelectArrayData selectData = SelectArrayData.fromJson(response);
          if (selectData != null) {
            if (selectData.data != null) {
              rows = selectData.data;
              if (rows != null && rows.length > 0) {
                setState(() {});
              }
            }
          }
        }
      },
      (error) {
        AppLogUtils.d(error.toString());
      },
    );
  }

  newqueryAll() {
    DioManager().post(
      Api.newqueryAll,
      arguments,
      headers,
      (response) {
        if (response != null) {
          SelectData selectData = SelectData.fromJson(response);
          if (selectData != null) {
            if (selectData.data != null) {
              rows = selectData.data.rows;
              if (rows != null && rows.length > 0) {
                setState(() {});
              }
            }
          }
        }
      },
      (error) {
        AppLogUtils.d(error.toString());
      },
    );
  }

  getParkChannels() {
    DioManager().post(
      Api.getParkChannels,
      arguments,
      headers,
      (response) {
        AppLogUtils.e(response.toString());
        if (response != null) {
          SelectData selectData = SelectData.fromJson(response);
          if (selectData != null) {
            if (selectData.data != null) {
              rows = selectData.data.rows;
              if (rows != null && rows.length > 0) {
                setState(() {});
              }
            }
          }
        }
      },
      (error) {
        AppLogUtils.d(error.toString());
      },
    );
  }

  /// 相机管理，智慧屏，液晶屏相关的 通道
  getAllChannel() {
    DioManager().post(
      Api.getAllChannel,
      arguments,
      headers,
      (response) {
        AppLogUtils.e(response.toString());
        if (response != null) {
          SelectArrayData selectData = SelectArrayData.fromJson(response);
          if (selectData != null) {
            if (selectData.data != null) {
              rows = selectData.data;
              if (rows != null && rows.length > 0) {
                setState(() {});
              }
            }
          }
        }
      },
      (error) {
        AppLogUtils.d(error.toString());
      },
    );
  }

  dynamic type = "";
  dynamic pageName = "";

  /// 周期
  getZhouqis() {
    type = arguments['type'];
    pageName = arguments['pageName'];
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
    if (pageName == "add") {
      rows.insert(
        0,
        SelectModel(
            valueNo: "0", valueName: "0" + type.toString(), isSelect: false),
      );
    }
    setState(() {});
  }

  /// 部门
  getBumens() {
    DioManager().post(Api.getAllGroup, arguments, headers, (response) {
      AppLogUtils.e(response.toString());
      if (response != null) {
        SelectArrayData selectData = SelectArrayData.fromJson(response);
        if (selectData != null) {
          if (selectData.data != null) {
            rows = selectData.data;
            if (rows != null && rows.length > 0) {
              setState(() {});
            }
          }
        }
      }
    }, (error) {
      AppLogUtils.d(error.toString());
    });
  }

  /// 产品
  getChanpins() {
    DioManager().post(Api.getpname, arguments, headers, (response) {
      AppLogUtils.e(response.toString());
      if (response != null) {
        SelectArrayData selectData = SelectArrayData.fromJson(response);
        if (selectData != null) {
          if (selectData.data != null) {
            rows = selectData.data;
            if (rows != null && rows.length > 0) {
              setState(() {});
            }
          }
        }
      }
    }, (error) {
      AppLogUtils.d(error.toString());
    });
  }

  int selectIndex = -1;

  onClick() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
    if (selectIndex == -1) {
      if (name == 'zhouqi') {
        if (_controller.text.isEmpty) {
          Navigator.maybePop(context);
        } else {
          SelectModel model = SelectModel(
            valueNo: _controller.text,
            valueName: _controller.text + type.toString(),
          );
          Navigator.maybePop(context, model.toJson());
        }
      } else {
        Navigator.maybePop(context);
      }
    } else {
      if (name == 'zhouqi') {
        if (_controller.text.isEmpty) {
          Navigator.maybePop(context, rows[selectIndex].toJson());
        } else {
          SelectModel model = SelectModel(
            valueNo: _controller.text,
            valueName: _controller.text + type.toString(),
          );
          Navigator.maybePop(context, model.toJson());
        }
      } else {
        Navigator.maybePop(context, rows[selectIndex].toJson());
      }
    }
  }

  appTitle() {
    String title = "";
    if (name == 'newqueryAll') {
      title = '车辆类型';
    } else if (name == 'getParkChannels') {
      title = '车场通道';
    } else if (name == 'zhouqi') {
      title = '周期';
    } else if (name == 'bumen') {
      title = '部门';
    } else if (name == 'chanpin') {
      title = '产品';
    } else if (name == 'getAllChannel') {
      title = '通道列表';
    } else if (name == 'address') {
      title = '区域';
    }
    return Text(
      title,
      style: TextStyle(
        color: ColorUtil.txtText,
        fontSize: 17,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    name = ModalRoute.of(context).settings.name;
    arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: ColorUtil.txtText57,
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () {
            Application.router.pop(context);
          },
        ),
        title: appTitle(),
        actions: [
          TextButton(
            onPressed: () {
              onClick();
            },
            child: Text(
              "确定",
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: name == 'zhouqi' ? 44 : 0,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text("自定义周期"),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
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
                        } else if (value.length > 0 &&
                            int.tryParse(value) > 100) {
                          _controller.text = "100";
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
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
                        if (name == 'zhouqi' &&
                            rows[selectIndex].valueNo != "0") {
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
          ],
        ),
      ),
    );
  }
}
