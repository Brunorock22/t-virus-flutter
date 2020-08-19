import 'package:flutter/material.dart';
import 'package:t_virus/ui/views/main_screen/main_navigator_bottom_controller.dart';

import 'init.dart';
import 'ui/shared/app_colors.dart';
import 'ui/views/welcome_page.dart';

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
      initialRoute: '/init',
      routes: {
        '/welcome_page': (context) => WelcomePage(),
        '/main_navigator': (context) => MainNavigatorBottomController(),
        '/init': (context) => InitialController(),
      },
    );
  }
}
