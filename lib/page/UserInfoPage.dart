import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:example01/bean/User.dart';
import 'package:example01/common/widget/LineView.dart';
import 'package:example01/page/dao/UserDao.dart';
import 'package:example01/state/GSYState.dart';
import 'package:example01/utils/AppUtils.dart';
import 'package:example01/utils/CommontUtils.dart';
import 'package:example01/utils/DensityUtil.dart';
import 'package:example01/utils/httpnet/Http.dart';
import 'package:example01/utils/httpnet/HttpContans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';

class UserInfoPage extends StatefulWidget {
  @override
  UserInfoPageState createState() => UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage> {
  User user;

  @override
  void initState() {
    super.initState();
    UserDao.getUserInfoLocal().then((obj) {
      if (obj != null && obj is User) {
        user = obj;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var line = LineView.line;

    return Scaffold(
      appBar: new AppBar(
        title: new Text("个人资料"), 
      ),
      body: new Column(
        children: <Widget>[
          getHeaderItems("头像", user != null ? user.portrait ?? "" : ""),
          line,
          getItems("昵称", user != null ? user.nickName ?? "" : ""),
          line,
          getItems("手机号码", user != null ? user.mobile ?? "" : ""),
          line,
          getItems("性别", user != null ? (user.sex == 1 ? "男" : "女") ?? "" : "")
        ],
      ),
    );
  }

  getItems(leftText, value) {
    return new Container(
      padding: EdgeInsets.all(DensityUtil.getwx(context, 15)),
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(leftText),
          new Text(value),
        ],
      ),
    );
  }

  getHeaderItems(leftText, value) {
    double pd = DensityUtil.getwx(context, 15);
    return new Container(
        padding: EdgeInsets.all(pd),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return _showNomalWid(context);
                });
          },
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(leftText),
              AppUtils.checkLoin(context) && user != null
                  ? new ClipOval(
                child: new Image.network(
                  value,
                  width: pd * 4,
                  height: pd * 4,
                ),
              )
                  : new Icon(Icons.tag_faces)
            ],
          ),
        ));
  }

  Widget _showNomalWid(BuildContext context) {
    return new Container(
      height: DensityUtil.getwx(context, 136),
      child: new Column(
        children: <Widget>[
          getText("拍照", () {
            getImage(1);
          }),
          LineView.line,
          getText("相册", () {
            getImage(2);
          }),
          LineView.line,
          getText("取消", () {
            getImage(0);
          }),
        ],
      ),
    );
  }

  Future getImage(value) async {
    Navigator.of(context).pop();
    if (value != 0) {
      var _image = await ImagePicker.pickImage(
          source: value == 1 ? ImageSource.camera : ImageSource.gallery);
      if (_image == null) {
        return null;
      }

      FormData formData = new FormData.from({
        "file": [new UploadFileInfo(_image, "avatar.png")]
      });
      CommontUtils.showLoadingDialog(context);
      Response response = await Http.getInstance().postImage(
          HttpContans.uploadPortrait + user.id.toString(), null, formData);
      Navigator.pop(context);
      if (response != null &&
          response.data != null &&
          response.statusCode == 200) {
        user.portrait = response.data['image'];
        Store<GSYState> store = StoreProvider.of(context);
        UserDao.saveUserInfo(user, store);
        print(json.encode(user));
        setState(() {});
      }
    }
  }

  getText(String value, Function doit) {
    return new Container(
      height: DensityUtil.getwx(context, 45),
      child: InkWell(
        child: new Center(
          child: new Text(value),
        ),
        onTap: doit,
      ),
    );
  }
}
