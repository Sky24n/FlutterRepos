import 'package:flutter/material.dart';
import 'package:base_library/base_library.dart';
import 'package:install_apk_plugin/install_apk_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setInitDir(initStorageDir: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            // 该地址可能无法下载，请自行更换可测试地址。
            String urlPath =
                'https://raw.githubusercontent.com/Sky24n/Doc/master/apks/flutter_wanandroid.apk';
            VersionModel model = VersionModel(
              title: '有新版本v0.2.6，快去更新吧！',
              content: '1.基础库升级 | 2.修复OPPO R15详情页问题 | 3.一些优化~',
              url: urlPath,
              version: '0.2.6',
            );
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => UpgradeDialog(
                versionModel: model,
                valueChanged: (value) {
                  /// iOS shield / iOS屏蔽
                  InstallPlugin.installApk(
                          value, 'com.library.base_library_example')
                      .then((result) {
                    LogUtil.e('install apk $result');
                  }).catchError((error) {
                    LogUtil.e('install apk error: $error');
                  });
                },
              ),
            );
          },
          child: Text('Version upgrade'),
        ),
      ),
    );
  }
}
