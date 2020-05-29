import 'package:base_library/src/models/model.dart';
import 'package:base_library/src/res/index.dart';
import 'package:base_library/src/util/version_util.dart';
import 'package:dio/dio.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

class UpgradeDialog extends StatefulWidget {
  const UpgradeDialog({
    Key key,
    this.versionModel,
    this.valueChanged,
  }) : super(key: key);
  final VersionModel versionModel;
  final ValueChanged valueChanged;

  @override
  State<StatefulWidget> createState() {
    return _UpgradeDialogState();
  }
}

class _UpgradeDialogState extends State<UpgradeDialog> {
  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)));

  VersionModel versionModel;

  List<String> listContent = List();

  int progress = 0;
  bool isDownload = false;

  OnDownloadProgress progressCallback;

  @override
  void initState() {
    super.initState();
    versionModel = widget.versionModel;

    progressCallback = (int count, int total) {
      progress = ((count / total) * 100).toInt();
//      LogUtil.e(
//          "ProgressCallback count: $count, total: $total, _progress: $progress");
      setState(() {});
      if (progress == 100) {
        Navigator.pop(context);
      }
    };

    VersionUtil().addListener(progressCallback);

//    versionModel.content = "1.基础库升级 | 2.修复OPPO R15详情页问题 | 3.一些优化~";
    if (ObjectUtil.isNotEmpty(versionModel.content))
      listContent = versionModel.content.split(' | ');
  }

  @override
  void dispose() {
    super.dispose();
    VersionUtil().removeListener(progressCallback);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 310.0, maxWidth: 310),
            child: Material(
              color: Colors.white,
              //elevation: _defaultElevation,
              shape: _defaultDialogShape,
              type: MaterialType.card,
              child: isDownload
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 310,
                              height: 100,
                              color: Colors.blue,
                            ),
                            Padding(
                              padding: EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Updating...',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                  Gaps.vGap5,
                                  Text(
                                    versionModel.version,
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Gaps.vGap20,
                        Offstage(
                          offstage: progress >= 0,
                          child: Text(
                            'Network exception, download failed!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14, color: Colors.redAccent),
                          ),
                        ),
                        Offstage(
                          offstage: progress < 0,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  style: TextStyle(
                                      fontSize: 14, color: Colours.text_normal),
                                  text: 'Progress '),
                              TextSpan(
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.blueAccent),
                                  text: "$progress%")
                            ]),
                          ),
                        ),
                        Gaps.vGap25,
                        Container(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          height: 4,
                          child: LinearProgressIndicator(
                            backgroundColor: Colours.green_e5,
                          ),
                        ),
                        Gaps.vGap5,
                        Center(
                          child: FlatButton(
                              onPressed: () {
                                if (progress >= 0) {
                                  Navigator.pop(context);
                                } else {
                                  VersionUtil().downloadApk(
                                    versionModel.url,
                                    widget.valueChanged,
                                  );
                                }
                              },
                              child: Text(
                                progress >= 0 ? 'Background Update' : 'Retry',
                                style: TextStyles.listExtra2,
                              )),
                        ),
                        Gaps.vGap5,
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              color: Colors.blue,
                              width: 310,
                              height: 100,
                            ),
                            Padding(
                              padding: EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'New Version',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                  ),
                                  Gaps.vGap5,
                                  Text(
                                    versionModel.version,
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 24, top: 12),
                          child: Text(
                            'Update Content',
                            style: TextStyles.listTitle,
                          ),
                        ),
                        Gaps.vGap15,
                        ListView.builder(
                            padding: EdgeInsets.only(left: 24, right: 24),
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            addRepaintBoundaries: false,
                            itemCount: listContent.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Text(
                                  listContent[index],
                                  style: TextStyles.listContent,
                                ),
                              );
                            }),
                        Gaps.vGap10,
                        Row(
                          children: <Widget>[
                            Gaps.hGap12,
                            Expanded(
                                child: FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Next',
                                      style: TextStyles.listExtra,
                                    ))),
                            Gaps.hGap5,
                            Expanded(
                                child: FlatButton(
                                    onPressed: () {
                                      VersionUtil().downloadApk(
                                        versionModel.url,
                                        widget.valueChanged,
                                      );
                                      setState(() {
                                        isDownload = true;
                                      });
                                    },
                                    child: Text(
                                      'Now',
                                      style: TextStyles.listExtra2,
                                    ))),
                            Gaps.hGap12,
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ));
  }
}
