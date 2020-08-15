import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomThemeApp {
  static ThemeData themeApp() {
    ThemeData(
      primaryColor: primaryColor,
      accentColor: accentColor,
      buttonTheme: ButtonThemeData(
        buttonColor: accentColor,

      ),
    );
  }
}
