import 'package:base_library/src/common/common.dart';
import 'package:flutter/material.dart';

class RouteUtil {
  static void goMain(BuildContext context) {
    pushReplacementNamed(context, BaseConstant.routeMain);
  }

  static void goLogin(BuildContext context) {
    pushNamed(context, BaseConstant.routeLogin);
  }

  static void pushNamed(BuildContext context, String pageName) {
    Navigator.of(context).pushNamed(pageName);
  }

  static void pushReplacementNamed(BuildContext context, String pageName) {
    Navigator.of(context).pushReplacementNamed(pageName);
  }
}
