import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef PopupMenuItemSelected<T> = void Function(T value);

// ignore: must_be_immutable
class CommonItem extends StatelessWidget {
  final leftText;

  final leftIcon;

  final rightText;

  final rightIcon;

  final PopupMenuItemSelected<String> onPressed;

  final TextStyle rightTextStyle;
  final TextStyle leftTextStyle;

  const CommonItem({
    this.leftText,
    this.leftIcon,
    this.leftTextStyle,
    this.rightText,
    this.rightIcon,
    this.onPressed,
    this.rightTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        this.onPressed(leftText);
      },
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new TextWithLeftIcon(
                          icon: this.leftIcon,
                          text: this.leftText,
                          textStyle: this.leftTextStyle),
                      new TextWithRightIcon(
                          icon: this.rightIcon,
                          text: this.rightText,
                          textStyle: this.rightTextStyle),
                    ])),
            new Container(
              height: 1,
              color: Color(0xFFeeeeee),
            )
          ],
        ),
      ),
    );
  }
}

class TextWithLeftIcon extends StatelessWidget {
  // ignore: must_be_immutable
  final String text;
  final TextStyle textStyle;
  final ImageProvider icon;

  const TextWithLeftIcon({this.text, this.textStyle, this.icon});

  @override
  Widget build(BuildContext context) {
    var lefticon;
    if (icon != null) {
      lefticon =
          new Image(image: icon, height: 32, width: 32, fit: BoxFit.fill);
    } else {
      lefticon = new Text("");
    }
    // TODO: implement build
    return new Container(
        child: new Row(
      children: <Widget>[
        lefticon,
        new Text(
          this.text,
          style: textStyle,
        ),
      ],
    ));
  }
}

class TextWithRightIcon extends StatelessWidget {
  // ignore: must_be_immutable
  final String text;
  final TextStyle textStyle;
  final ImageProvider icon;

  const TextWithRightIcon({this.text, this.textStyle, this.icon});

  @override
  Widget build(BuildContext context) {
    var lefticon;
    if (icon != null) {
      lefticon =
          new Image(image: icon, height: 30, width: 30, fit: BoxFit.fill);
    } else {
      IconData iconData = Icons.chevron_right;
      lefticon = new Icon(iconData, color: Color(0xff666666));
    }

    // TODO: implement build
    return new Container(
        child: new Row(
      children: <Widget>[
        new Text(
          this.text,
          style: this.textStyle,
        ),
        lefticon,
      ],
    ));
  }
}
