import 'package:cloud/routes/application.dart';
import 'package:cloud/utils/color_util.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({
    Key key,
    this.titleS,
    this.actions,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  final String titleS;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: ColorUtil.txtText57,
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        onPressed: () {
          Application.router.pop(context);
        },
      ),
      title: titleS != null
          ? Text(
              titleS,
              style: TextStyle(fontSize: 17.0, color: ColorUtil.txtText),
            )
          : null,
      actions: actions,
    );
  }
}
