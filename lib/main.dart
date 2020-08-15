import 'package:flutter/material.dart';
import 'package:t_virus/ui/register_survivor.dart';
import 'package:t_virus/ui/welcome_page.dart';

import 'ui/shared/app_colors.dart';
import 'ui/shared/theme_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        buttonTheme: ButtonThemeData(
          buttonColor: accentColor,

        ),
      ),
      initialRoute: '/welcome_page',
      routes: {
        '/welcome_page': (context) => WelcomePage(),
        '/register_survivor': (context) => RegisterSurvivor(),
      },
    );
  }
}
