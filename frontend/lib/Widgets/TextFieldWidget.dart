import 'package:worldcup/Constants/Colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final Size deviceSize;
  final TextEditingController controller;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final Function suffixOnTap;
  final bool obscureText;
  final String labelText;
  final double width;
  final bool isFieldEnabled;
  final TextInputType inputType;

  const TextFieldWidget(
      {this.deviceSize,
      this.isFieldEnabled = true,
      this.controller,
      this.prefixIconData,
      this.suffixIconData,
      this.suffixOnTap,
      this.obscureText = false,
      this.labelText,
      this.width,
      this.inputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: deviceSize.width * (0.4 / width),
          height: deviceSize.height * 0.08,
          margin: EdgeInsets.all(deviceSize.height * 0.01),
          child: Theme(
            data: ThemeData(primaryColor: Colors.black26),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: TextFormField(
                keyboardType: inputType,
                enabled: isFieldEnabled,
                textAlign: TextAlign.left,
                onChanged: (value) {},
                obscureText: obscureText,
                controller: controller,
                decoration: InputDecoration(
                  labelText: labelText,
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ConstantColors.purple, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[900], width: 1.0),
                  ),
                ),
                style: TextStyle(color: Colors.black87),
                cursorColor: Colors.purple,
                validator: (value) {
                  if (labelText == "Email") {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  } else if (labelText == "Password") {
                    if (value.isEmpty || value.length < 8) {
                      return 'Please enter a password greater than or equal 8';
                    }
                    return null;
                  } else if (labelText == "Password Confirmation") {
                    if (value.isEmpty || value.length < 8) {
                      return 'Please enter a password confirmation greater than or equal 8';
                    }
                    return null;
                  } else if (labelText == "User Name") {
                    if (value.isEmpty || value.length < 4) {
                      return 'Please enter a user name greater than or equal 4';
                    }
                    return null;
                  } else if (labelText == "Email/Username") {
                    if (value.isEmpty) {
                      return 'Please enter a valid Email or Username';
                    }
                    return null;
                  } else if (labelText == "First Name" ||
                      labelText == "Last Name" ||
                      labelText == "Gender" ||
                      labelText == "Date of birth") {
                    if (value.isEmpty) {
                      return 'Please fill the empty field';
                    }
                    return null;
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
