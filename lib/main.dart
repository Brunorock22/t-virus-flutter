import 'package:flutter/material.dart';
import 'package:t_virus/ui/welcome_page.dart';

import 'ui/shared/app_colors.dart';

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
          textTheme: ButtonTextTheme.accent,
            buttonColor: accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              //side: BorderSide(color: Colors.brown),
            )),
      ),
      initialRoute: '/welcome_page',
      routes: {
        '/welcome_page': (context) => WelcomePage(),
      },
    );
  }
}
