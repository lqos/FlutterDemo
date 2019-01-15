import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateWheel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DateWheelState();
  }
}

class DateWheelState extends State<DateWheel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('日期选择'),
        actions: <Widget>[
          InkWell(
            onTap: () {
              showTipDialog(
                  getYear() + '年' + getMonth() + '月' + getDay() + '日');
            },
            child: Center(
              child: Text('确定  '),
            ),
          )
        ],
      ),
      body: InkWell(
        onTap: () {
          show();
        },
        child: Center(
          child: Text('弹框'),
        ),
      ),
    );
  }

  showTipDialog(String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => showAlertDialog(message));
  }

  AlertDialog showAlertDialog(String content) {
    return AlertDialog(
      title: Text("提示"),
      content: new Container(
        height: 30,
        child: new Column(
          children: <Widget>[
            new Text(content),
          ],
        ),
      ),
      actions: <Widget>[
        new Container(
          child: new Padding(
              padding: EdgeInsets.all(10),
              child: new InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: new Text(
                  "确定",
                  style: new TextStyle(
                      fontSize: 15, color: Theme.of(context).accentColor),
                ),
              )),
        ),
      ],
    );
  }

  FixedExtentScrollController _fixedExtentScrollController;
  FixedExtentScrollController _fixedExtentScrollController2;

  wheel() {
    if (_fixedExtentScrollController == null) {
      _fixedExtentScrollController = FixedExtentScrollController();
    }
    if (_fixedExtentScrollController2 == null) {
      _fixedExtentScrollController2 = FixedExtentScrollController();
    }
    double wh = 150;
    return Container(
      height: wh + 30,
      child: Column(
        children: <Widget>[
          Container(
            height: 30,
            margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("取消"),
                ),
                Text("日期选择"),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    showTipDialog(
                        getYear() + '年' + getMonth() + '月' + getDay() + '日');
                  },
                  child: Text("确定"),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                width: 120,
                height: wh,
                padding: EdgeInsets.all(5),
                child: CupertinoPicker(
                  itemExtent: 16,
                  onSelectedItemChanged: (int value) {
                    setState(() {
                      Y = startYear + value;
                      print(Y.toString());
                      _fixedExtentScrollController.jumpToItem(0);
                      _fixedExtentScrollController2.jumpToItem(0);
                    });
                  },
                  children: buildYearList(),
                ),
              ),
              Container(
                width: 120,
                height: wh,
                padding: EdgeInsets.all(5),
                child: CupertinoPicker(
                  itemExtent: 16,
                  scrollController: _fixedExtentScrollController2,
                  onSelectedItemChanged: (int value) {
                    setState(() {
                      M = value + 1;
                      print(M.toString());
                      _fixedExtentScrollController.jumpToItem(0);
                    });
                  },
                  children: buildMonthList(),
                ),
              ),
              Container(
                width: 120,
                height: wh,
                padding: EdgeInsets.all(5),
                child: CupertinoPicker(
                  itemExtent: 16,
                  scrollController: _fixedExtentScrollController,
                  onSelectedItemChanged: (int value) {
                    print(value.toString());
                    D = value + 1;
                  },
                  children: buildDayList(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  getYear() {
    return Y.toString();
  }

  getMonth() {
    if (M >= 10)
      return M.toString();
    else {
      return '0$M';
    }
  }

  getDay() {
    if (D >= 10)
      return D.toString();
    else {
      return '0$D';
    }
  }

  var startYear = 1970;
  var endYear = 2070;
  var Y = 2010;
  var M = 1;
  var D = 1;

  buildYearList() {
    List<Widget> list = [];
    for (int i = startYear; i <= endYear; i++) {
      list.add(getTextWidget('$i年'));
    }
    return list;
  }

  buildMonthList() {
    List<Widget> list = [];
    for (int i = 1; i < 13; i++) {
      if (i < 10) {
        list.add(getTextWidget('0$i月'));
      } else {
        list.add(getTextWidget('$i月'));
      }
    }
    return list;
  }

  getTextWidget(String data) {
    return Text(
      data,
      style: TextStyle(fontSize: 16),
    );
  }

  buildDayList() {
    List<Widget> list = [];
    int count = getSum(M);
    print(Y.toString() + "-" + M.toString() + "-" + count.toString());
    for (int i = 1; i <= count; i++) {
      if (i < 10) {
        list.add(getTextWidget('0$i日'));
      } else {
        list.add(getTextWidget('$i日'));
      }
    }
    return list;
  }

  getSum(month) {
    if (month == 1) {
      return 31;
    } else if (month == 2) {
      if (Y % 4 == 0 && Y % 100 != 0 || Y % 400 == 0) {
        return 29;
      } else {
        return 28;
      }
    } else if (month == 3) {
      return 31;
    } else if (month == 4) {
      return 30;
    } else if (month == 5) {
      return 31;
    } else if (month == 6) {
      return 30;
    } else if (month == 7) {
      return 31;
    } else if (month == 8) {
      return 31;
    } else if (month == 9) {
      return 30;
    } else if (month == 10) {
      return 31;
    } else if (month == 11) {
      return 30;
    } else if (month == 12) {
      return 31;
    }
  }

  void show() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return wheel();
        });
  }
}
