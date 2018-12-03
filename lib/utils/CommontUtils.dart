import 'package:example01/utils/DensityUtil.dart';
import 'package:flutter/material.dart';

class CommontUtils {
  static Future<Null> showLoadingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Material(
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () => new Future.value(false),
                child: Center(
                  child: new Container(
                    width: DensityUtil.getwx(context, 150),
                    height: DensityUtil.getwx(context, 150),
                    padding: new EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      //用一个BoxDecoration装饰器提供背景图片
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RefreshProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
