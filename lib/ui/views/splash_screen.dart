import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:t_virus/core/util/utils.dart';
import 'package:t_virus/ui/shared/app_colors.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: [0.3, 0.9],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: backgroundGradientColor)),
        child: FadeTransition(
            opacity: animation,
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                width: Utils.getWidthOfScreen(context: context) * 0.5,
                height: Utils.getWidthOfScreen(context: context) * 0.5,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                          width: Utils.getWidthOfScreen(context: context) /3,
                          child: Image.asset("images/ic_zombie_face.png")
                      ),
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }
}