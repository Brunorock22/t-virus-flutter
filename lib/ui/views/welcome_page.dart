import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:t_virus/core/util/utils.dart';

import '../shared/app_colors.dart';
import '../widgets/custom_material_button.dart';
import 'register_survivor/stepper_register_survivor_controller.dart';

class WelcomePage extends StatelessWidget{
  @override
  Widget build(BuildContext mContext) {
    var heigthOfScreen = Utils.getHeightOfScreen(context: mContext);
    var widthOfScreen = Utils.getWidthOfScreen(context: mContext);
    var topRadiusBorders = Radius.circular(40.0);
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 35.0),
        child: Column(
          children: [
            Image.asset(
              "images/ic_zombie_face.png",
              width: widthOfScreen / 4,
            ),
            Text(
              'Welcome to the world\'s end ',
              style: TextStyle(
                  fontFamily: 'ZOMBIE', color: accentColor, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: topRadiusBorders, topRight: topRadiusBorders),
                ),
                child: Container(
                  height: heigthOfScreen,
                  width: widthOfScreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Be a badass fighting against the cancellations waves',
                        style: TextStyle(
                            fontFamily: 'ZOMBIETEXT',
                            color: textsColor,
                            fontSize: 18),
                        textAlign: TextAlign.center,
                      )
                      ,Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'The world, as we know it, has fallen into an apocalyptic scenario. The "Influenzer T-Virus" (a.k.a. Twiter Virus) is transforming human beings into stupid beasts (a.k.a. Zombies), hungry to cancel humans and eat their limbs.',
                          style: TextStyle(
                              fontFamily: 'ZOMBIETEXT',
                              color: textsColor,
                              fontSize: 11),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "images/ic_zombie_hand_pointing_down.png",
                          width: widthOfScreen / 7,
                        ),
                      ),
                      customMaterialButton(
                          title: 'START', fontFamily: "ZOMBIETEXT", navigateToScreen: StepperRegisterSuvivorController(),context: mContext,backgroundColor: secondaryColor)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
