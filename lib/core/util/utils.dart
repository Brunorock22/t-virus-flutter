import 'package:flutter/material.dart';

class Utils {
  static double getWidthOfScreen({ BuildContext context}) {
    double _widthCalculated = MediaQuery.of(context).size.width ;
    return _widthCalculated;
  }

  static double getHeightOfScreen({ @required BuildContext context}) {
    double _heightCalculated =  MediaQuery.of(context).size.height ;
    return _heightCalculated;
  }
}
