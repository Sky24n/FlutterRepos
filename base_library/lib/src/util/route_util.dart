import 'package:base_library/src/common/common.dart';
import 'package:flutter/material.dart';

class RouteUtil {
  static void goMain(BuildContext context) {
    pushPageName(context, BaseConstant.routeMain);
  }

  static void goLogin(BuildContext context) {
    pushPageName(context, BaseConstant.routeLogin);
  }

  static void pushPageName(BuildContext context, String pageName) {
    Navigator.of(context).pushReplacementNamed(pageName);
  }
}
