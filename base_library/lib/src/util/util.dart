import 'package:base_library/src/common/common.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class Util {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text("$msg")),
    );
  }

  static bool isLogin() {
    return ObjectUtil.isNotEmpty(SpUtil.getString(BaseConstant.keyAppToken));
  }
}
