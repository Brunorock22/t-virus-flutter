import 'package:flutter/material.dart';
import 'package:t_virus/ui/shared/app_colors.dart';


import 'steps/step_survivor_information.dart';
import 'steps/step_survivor_supplies.dart';

class StepperRegisterSuvivorController extends StatefulWidget {
  @override
  _StepperRegisterSuvivorControllerState createState() =>
      _StepperRegisterSuvivorControllerState();
}

class _StepperRegisterSuvivorControllerState
    extends State<StepperRegisterSuvivorController> {
  bool maleCheck = false;
  bool femaleCheck = false;
  int _currentStep = 0;

  final TextEditingController survivorName = TextEditingController();
  final TextEditingController survivorAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Size of cicle container with the app icon
    final double circleRadius = 100.0;
    final double circleBorderWidth = 8.0;

    return Scaffold(
      backgroundColor: secondaryColor,
      body: new Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepTapped: (int step) => setState(() => _currentStep = step),
          onStepContinue:
              _currentStep < 1 ? () => setState(() => _currentStep += 1) : null,
          onStepCancel:
              _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RaisedButton.icon(
                    icon: Icon(
                      Icons.navigate_next,
                      color: primaryColor,
                    ),
                    onPressed: onStepContinue,
                    label: Text('CONTINUE'),
                    textColor: primaryColor,
                    color: accentColor,
                  ),
                ],
              ),
            );
          },
          steps: <Step>[
            new Step(
              title: new Text('Survivor'),
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 0 ? StepState.complete : StepState.disabled,
              content: StepSurvivorInformation(),
            ),
            Step(
              title: new Text('Shipping'),
              content: StepSurvivorSupplies(),
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 1 ? StepState.complete : StepState.disabled,
            )
          ]),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: accentColor,
                thickness: 1,
              ),
            ),
          ),
          Text(
            'Gender',
            style: TextStyle(color: accentColor),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: accentColor,
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
