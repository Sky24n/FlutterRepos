import 'package:flutter/material.dart';

import 'package:base_library/base_library.dart';

import 'login_page.dart';
import 'main_page.dart';

class MyAppDemo2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppDemoState2();
  }
}

class MyAppDemoState2 extends State<MyAppDemo2> {
  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  ///异步初始化sp。
  void _initAsync() async {
    await SpUtil.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: {
        BaseConstant.routeMain: (ctx) => MainPage(),
        BaseConstant.routeLogin: (ctx) => LoginPage(),
      },
      home: SplashPage(),
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.deepPurpleAccent,
      ),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    ///默认展示1秒启动图。
    Future.delayed(new Duration(milliseconds: 1000), () async {
      ///再次确保sp完全初始化。
      await SpUtil.getInstance();

      ///是否显示引导页。
      if (SpUtil.getBool(BaseConstant.keyShowGuide, defValue: true)) {
        _initGuide();
      } else {
        _initSplash();
      }
    });
  }

  ///引导页逻辑。
  void _initGuide() {
    ///.... 引导页逻辑已完。
    ///已登录，跳转到主页。
    ///未登录跳登录页。
    if (Util.isLogin()) {
      RouteUtil.goMain(context);
    } else {
      RouteUtil.pushReplacementNamed(context, BaseConstant.routeLogin);
    }
  }

  ///闪屏广告逻辑
  void _initSplash() {
    ///已登录，显示3秒广告图后，跳转到主页。
    ///未登录跳登录页。
    if (Util.isLogin()) {
      Future.delayed(new Duration(milliseconds: 3000), () {
        RouteUtil.goMain(context);
      });
    } else {
      RouteUtil.pushReplacementNamed(context, BaseConstant.routeLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Splash'),
      ),
      body: new Center(
        child: new Text("Splash"),
      ),
    );
  }
}
