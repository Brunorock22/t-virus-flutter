import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:t_virus/core/service/gps_service.dart';
import 'package:t_virus/ui/shared/app_colors.dart';
import 'package:t_virus/ui/widgets/custom_outline_text_field.dart';
import 'package:t_virus/ui/widgets/flushbar_custom.dart';

class StepSurvivorSupplies extends StatefulWidget {
  @override
  _StepSurvivorSuppliesState createState() => _StepSurvivorSuppliesState();
}

class _StepSurvivorSuppliesState extends State<StepSurvivorSupplies> {
  bool maleCheck = false;
  bool femaleCheck = false;

  final TextEditingController survivorName = TextEditingController();
  final TextEditingController survivorAge = TextEditingController();

  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;

  @override
  Widget build(BuildContext context) {
    return  Column(
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
                            heigth: 50),
                        showMaterialTextFiel(survivorAge, "Age",
                            heigth: 50,
                            inputType: TextInputType.number,
                            maxLength: 3),
                        _divider(),
                        _genderCheckBox()
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
        SizedBox(
          height: 50,
        ),
      ],
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

  Widget _genderCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Image.asset(
              "images/ic_zombie_male.png",
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Male",
                style: TextStyle(color: textsColor, fontFamily: "ZOMBIE"),
              ),
            ),
            CircularCheckBox(
                value: maleCheck,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                onChanged: (bool touched) {
                  setState(() {
                    if (touched) {
                      maleCheck = touched;
                      femaleCheck = false;
                    } else {
                      maleCheck = touched;
                      femaleCheck = true;
                    }
                  });
                }),
          ],
        ),
        Column(
          children: [
            Image.asset(
              "images/ic_zombie_female.png",
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Female",
                style: TextStyle(color: textsColor, fontFamily: "ZOMBIE"),
              ),
            ),
            CircularCheckBox(
                value: femaleCheck,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                onChanged: (bool touched) {
                  setState(() {
                    if (touched) {
                      femaleCheck = touched;
                      maleCheck = false;
                    } else {
                      femaleCheck = touched;
                      maleCheck = true;
                    }
                  });
                }),
          ],
        ),
      ],
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
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 0.0),
      child: new MaterialButton(
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
      ),
    );
  }

  void verifyField() {
    if (survivorName.text == "") {
      FlusBarCustom(
          "Fill the field Name.",
          context,
          Icon(
            Icons.error,
            color: errorColor,
          )).flushbar();
    } else if (survivorAge.text == "") {
      FlusBarCustom(
          "Fill the field Age.",
          context,
          Icon(
            Icons.error,
            color: errorColor,
          )).flushbar();
    } else if (!femaleCheck && !maleCheck) {
      FlusBarCustom(
          "Check the Gender box..",
          context,
          Icon(
            Icons.error,
            color: errorColor,
          )).flushbar();
    } else {
      getUserLocation().then((value) {
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => StepperWidget()));
      });
    }
  }

  Future<Position> getUserLocation() async {
    GPSService gpsService = GPSService();
    return gpsService.getUserLocation();
  }
}
