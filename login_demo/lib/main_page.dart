import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _userName =
        Util.isLogin() ? SpUtil.getString(BaseConstant.keyUserName) : "";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            height: 50,
            child: new Center(
              child: new Text("用户名：$_userName"),
            ),
          ),
          new RoundButton(
            text: Util.isLogin() ? "退出" : "未登录",
            margin: EdgeInsets.all(12),
            onPressed: () {
              if (Util.isLogin()) {
                SpUtil.remove(BaseConstant.keyAppToken);
                setState(() {});
              } else {
                RouteUtil.goLogin(context);
              }
            },
          )
        ],
      ),
    );
  }
}
