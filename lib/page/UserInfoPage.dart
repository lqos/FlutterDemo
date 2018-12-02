import 'package:example01/bean/User.dart';
import 'package:example01/page/dao/UserDao.dart';
import 'package:example01/utils/AppUtils.dart';
import 'package:example01/utils/DensityUtil.dart';
import 'package:flutter/material.dart';

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
    var line = new Container(
      color: Color(0xffdddddd),
      height: DensityUtil.getwx(context, 0.5),
    );

    return Scaffold(
      appBar: new AppBar(
        title: new Text("个人资料"),
        centerTitle: true,
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
    );
  }
}
