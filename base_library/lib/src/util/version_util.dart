import 'dart:io';

import 'package:base_library/src/util/index.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';

class VersionUtil {
  static final VersionUtil _singleton = VersionUtil._init();

  static Dio _dio = Dio();

  List<OnDownloadProgress> listeners = List();

  bool isDownload = false;

  factory VersionUtil() {
    return _singleton;
  }

  VersionUtil._init();

  void downloadApk(String urlPath,  ValueChanged changed) async {
    if (isDownload == true || ObjectUtil.isEmpty(urlPath)) return;
    try {
      await DirectoryUtil.getInstance();
      String apkDirPath = DirectoryUtil.getStoragePath(category: 'Download');
      LogUtil.e("apkDirPath: $apkDirPath");
      Directory apkDir = DirectoryUtil.createDirSync(apkDirPath);

      String apkName = Util.getFileName(urlPath);
      String apkPath = '$apkDirPath/$apkName';
      String apkTempPath = '$apkDirPath/temp_$apkName';

      LogUtil.e("apkPath: $apkPath");
      LogUtil.e("apkTempPath: $apkTempPath");

      File file = File(apkPath);
      if (file.existsSync()) {
        changed(apkPath);
        isDownload = false;
        listeners.forEach((listener) {
          listener(1, 1);
        });
        return;
      }
      isDownload = true;
      Response response = await _dio.download(
        urlPath,
        apkTempPath,
        onProgress: (int count, int total) {
          LogUtil.e(
              "onReceiveProgress total: $total, count: $count, prect: ${count / total}");
          listeners.forEach((listener) {
            listener(count, total);
          });
          if (count == total) {
            isDownload = false;
            File file = File(apkTempPath);
            File fileNew = file.copySync(apkPath);
            file.deleteSync();
            changed(apkPath);
          }
        },
      );
    } catch (e) {
      LogUtil.e("download apk error: ${e?.toString()}");
      isDownload = false;
      listeners.forEach((listener) {
        listener(-1, 1);
      });
    }
  }

  void addListener(OnDownloadProgress listener) {
    if (listener == null) return;
    if (!listeners.contains(listener)) {
      listeners.add(listener);
    }
  }

  void removeListener(OnDownloadProgress listener) {
    if (listener == null) return;
    if (listeners.contains(listener)) {
      listeners.remove(listener);
    }
  }
}
