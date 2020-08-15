import 'package:flutter/material.dart';
import 'package:t_virus/ui/shared/app_colors.dart';

Widget customMaterialButton(
    {title: String, Color backgroundColor = accentColor,
    fontFamily: String,
    minWidth = 150.0,
    Color textColor = accentColor,
    @required BuildContext context,
    @required Widget navigateToScreen}) {
  return new Padding(
    padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
    child: new MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      elevation: 1.0,
      minWidth: minWidth,
      height: 35,
      color: backgroundColor,
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => navigateToScreen)),
      child: new Text(title,
          style: new TextStyle(
              fontSize: 16.0, color: textColor, fontFamily: fontFamily)),
    ),
  );
}
