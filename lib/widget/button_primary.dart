import 'package:austindo/styles/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget primaryButton(title, onFunction()) {
  final InkWell loginButtonWithGesture = new InkWell(
    onTap: () {
      onFunction();
    },
    child: new Container(
      height: 50.0,
      decoration: new BoxDecoration(
          color: Colors.amber,
          borderRadius: new BorderRadius.all(Radius.circular(5.0))),
      child: new Center(
        child: new Text(
          title.toString(),
          style: fontStylePrimaryButton(),
        ),
      ),
    ),
  );

  return new Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 30.0),
      child: loginButtonWithGesture);
}
