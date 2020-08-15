import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_virus/ui/shared/app_colors.dart';

Widget showMaterialTextFiel(TextEditingController controller, String title,
    {TextInputType inputType = TextInputType.text,
    IconData icon,
    TextAlign alingment,
    bool isPassword = false,
    Color containerColor,
    Color iconColor,
    double heigth = 50.0,
    Color borderColor,
    int maxLength,
    FocusNode myFocusNode,
    readOnly = false,
    enable = true}) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(
      color: containerColor,
      height: heigth,
      child: TextField(
        focusNode: myFocusNode = FocusNode(),
        style: TextStyle(color: accentColor),
        cursorColor: accentColor,
        readOnly: readOnly,
        enabled: enable,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
        ],
        textAlign: alingment == null ? TextAlign.start : alingment,
        keyboardType: inputType,
        controller: controller,
        decoration: new InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: accentColor, width: 0.0),
            ),
            suffixIcon: Icon(icon, color: iconColor),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: accentColor, width: 0.0),
            ),
            labelText: title,
            labelStyle: TextStyle(
                color: myFocusNode.hasFocus ? accentColor : accentColor)

            //labelStyle: new TextStyle(color: Colors.green),
            ),
      ),
    ),
  );
}
