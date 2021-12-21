import 'package:cloud/http/api.dart';
import 'package:cloud/http/dio_manager.dart';
import 'package:cloud/model/select_data.dart';
import 'package:cloud/pagers/log/app_logutils.dart';
import 'package:cloud/routes/global.dart';
import 'package:cloud/utils/color_util.dart';
import 'package:flutter/material.dart';

class SelectDataDialog extends StatefulWidget {
  SelectDataDialog({
    Key key,
    this.pageName = "",
    this.changed,
  }) : super(key: key);

  final String pageName;
  final ValueChanged<SelectModel> changed;

  @override
  State<StatefulWidget> createState() {
    return _SelectDataDialogState();
  }
}

class _SelectDataDialogState extends State<SelectDataDialog> {
  String title = "";

  List<SelectModel> rows = [];
  int selectIndex = -1;

  Map<String, dynamic> headers = {};
  Map<String, dynamic> params = {};

  @override
  void initState() {
    super.initState();
    headers = {"tpnsToken": Global.login.token};
    params = {"comid": Global.login.comid};

    if (widget.pageName == 'carType') {
      title = '车辆类型';
      newQueryAll();
    } else if (widget.pageName == 'getParkChannels_in') {
      title = '车场通道';
      params = {
        "comid": Global.login.comid,
        "passType": 0,
      };
      getParkChannels();
    } else if (widget.pageName == 'getParkChannels_out') {
      title = '车场通道';
      params = {
        "comid": Global.login.comid,
        "passType": 1,
      };
      getParkChannels();
    } else if (widget.pageName == 'department') {
      title = '选择部门';
      getAllGroup();
    } else if (widget.pageName == 'product') {
      title = '包月产品';
      getProducts();
    } else if (widget.pageName == 'getAllChannel') {
      title = '选择通道';
      getAllChannel();
    } else if (widget.pageName == 'address') {
      title = '选择区域';
      getAddress();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Container(
        width: 284,
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
                    title,
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
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      rows.forEach((element) {
                        element.isSelect = false;
                      });
                      setState(() {
                        selectIndex = index;
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
    if (selectIndex == -1) {
      print("啥都没选，就这么退出呗");
    } else {
      if (widget.changed != null) {
        widget.changed(rows[selectIndex]);
      }
    }
    Navigator.of(context).pop(true);
  }

  /// 车辆类型
  newQueryAll() {
    DioManager().post(
      Api.newqueryAll,
      params,
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

  /// 车场通道
  getParkChannels() {
    DioManager().post(
      Api.getParkChannels,
      params,
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

  /// 部门
  getAllGroup() {
    DioManager().post(
      Api.getAllGroup,
      params,
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

  /// 产品
  getProducts() {
    DioManager().post(
      Api.getpname,
      params,
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

  /// 相机管理，智慧屏，液晶屏相关的 通道
  getAllChannel() {
    DioManager().post(
      Api.getAllChannel,
      params,
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

  /// 区域
  getAddress() {
    DioManager().post(
      Api.getComArea,
      params,
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
}
