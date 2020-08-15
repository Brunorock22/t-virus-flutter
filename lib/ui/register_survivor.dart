import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:t_virus/ui/shared/app_colors.dart';
import 'package:t_virus/ui/widgets/custom_outline_text_field.dart';

import 'widgets/custom_material_button.dart';

class RegisterSurvivor extends StatefulWidget {
  @override
  _RegisterSurvivorState createState() => _RegisterSurvivorState();
}

class _RegisterSurvivorState extends State<RegisterSurvivor> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController survivorName = TextEditingController();
    final TextEditingController survivorAge = TextEditingController();
    final TextEditingController teste = TextEditingController();

    //Size of cicle container with the app icon
    final double circleRadius = 100.0;
    final double circleBorderWidth = 8.0;

    bool someBooleanValue = false;

    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: EdgeInsets.only(right: 40, left: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: circleRadius / 2.0),
                  child: Card(
                    child: ColoredBox(
                      color: primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Column(
                          children: <Widget>[
                            showMaterialTextFiel(survivorName, "Name",
                                heigth: 40),
                            showMaterialTextFiel(teste, "Age", heigth: 40, inputType: TextInputType.number, maxLength: 3),
                            CircularCheckBox(
                                value: someBooleanValue,
                                materialTapTargetSize: MaterialTapTargetSize.padded,
                                onChanged: (bool x) {
                                  setState(() {
                                    someBooleanValue = !someBooleanValue;

                                  });
                                }
                            )
                          ],
                        ),
                      ),
                    ),
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: circleRadius,
                  height: circleRadius,
                  decoration: ShapeDecoration(
                      shape: CircleBorder(), color: primaryColor),
                  child: Padding(
                    padding: EdgeInsets.all(circleBorderWidth),
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'images/ic_zombie_circular.png',
                              ))),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            customMaterialButton(
              textColor: primaryColor,
                title: 'START',
                fontFamily: "ZOMBIETEXT",
                navigateToScreen: RegisterSurvivor(),
                context: context),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
