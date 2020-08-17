import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:t_virus/core/model/location.dart';
import 'package:t_virus/core/model/survivor.dart';
import 'package:t_virus/core/service/gps_service.dart';
import 'package:t_virus/ui/shared/app_colors.dart';
import 'package:t_virus/ui/welcome_page.dart';
import 'package:t_virus/ui/widgets/flushbar_custom.dart';

import 'steps/step_survivor_information.dart';
import 'steps/step_survivor_supplies.dart';

class StepperRegisterSuvivorController extends StatefulWidget {
  @override
  _StepperRegisterSuvivorControllerState createState() =>
      _StepperRegisterSuvivorControllerState();
}

class _StepperRegisterSuvivorControllerState
    extends State<StepperRegisterSuvivorController> {
  int _currentStep = 0;

  Survivor survivor = Survivor();

  TextEditingController survivorName = TextEditingController();
  TextEditingController survivorAge = TextEditingController();

  bool isFieldsFilled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: GestureDetector(
          onTap: () {
            //If user touch out of fields the keyborad will disapear
            FocusScope.of(context).requestFocus(new FocusNode());
          },
        child: new Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepTapped: (int step) => setState(() => _currentStep = step),
            onStepContinue:
                _currentStep < 1 ? () => setState(() => _currentStep += 1) : null,
            onStepCancel:
                _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
            controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _currentStep == 1 // this is the last step
                      ? sendButton(
                          textColor: primaryColor,
                          title: 'SEND',
                          fontFamily: "ZOMBIE",
                          navigateToScreen: WelcomePage(),
                          context: context)
                      : RaisedButton.icon(
                          icon: Icon(
                            Icons.navigate_next,
                            color: primaryColor,
                          ),
                          // ignore: unrelated_type_equality_checks
                          onPressed: onStepContinue,
                          label: Text(
                            'CONTINUE',
                            style: TextStyle(fontFamily: "ZOMBIE", fontSize: 25),
                          ),
                          textColor: primaryColor,
                          color: accentColor,
                        ),
                ],
              );
            },
            steps: <Step>[
              new Step(
                title: new Text(
                  'Survivor Informations',
                  style: TextStyle(
                      color: accentColor,
                      fontFamily: 'ZOMBIETEXT',
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 0 ? StepState.complete : StepState.disabled,
                content:
                    StepSurvivorInformation(survivor, survivorName, survivorAge),
              ),
              Step(
                title: new Text(
                  'Supplies',
                  style: TextStyle(
                      color: accentColor,
                      fontFamily: 'ZOMBIETEXT',
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                content: StepSurvivorSupplies(survivor),
                isActive: _currentStep >= 0,
                state:
                    _currentStep >= 1 ? StepState.complete : StepState.disabled,
              )
            ]),
      ),
    );
  }

  Widget sendButton(
      {title: String,
      Color backgroundColor = accentColor,
      fontFamily: String,
      minWidth = 150.0,
      Color textColor = accentColor,
      @required BuildContext context,
      @required Widget navigateToScreen}) {
    return new MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      elevation: 1.0,
      minWidth: minWidth,
      height: 35,
      color: backgroundColor,
      onPressed: () => verifyField(),
      child: new Text(title,
          style: new TextStyle(
              fontSize: 25.0, color: textColor, fontFamily: fontFamily)),
    );
  }

  bool verifyField() {
    if (survivorName.text == "") {
      FlusBarCustom(
          "Fill the field Name.",
          context,
          Icon(
            Icons.error,
            color: errorColor,
          )).flushbar();
      return isFieldsFilled = false;
    } else if (survivorAge.text == "") {
      FlusBarCustom(
          "Fill the field Age.",
          context,
          Icon(
            Icons.error,
            color: errorColor,
          )).flushbar();
      return isFieldsFilled = false;
    } else if (survivor.gender == null) {
      print(survivor.gender);
      FlusBarCustom(
          "Check the Gender box..",
          context,
          Icon(
            Icons.error,
            color: errorColor,
          )).flushbar();
      return isFieldsFilled = false;
    } else {
      survivor.age = int.parse(survivorAge.text);
      getUserLocation().then((value) {
        LatLog latLog =
            LatLog(latitude: value.latitude, longitude: value.longitude);
        survivor.location = latLog;
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => StepperWidget()));
      });
      return isFieldsFilled = true;
    }
  }

  Future<Position> getUserLocation() async {
    GPSService gpsService = GPSService();
    return gpsService.getUserLocation();
  }
}
