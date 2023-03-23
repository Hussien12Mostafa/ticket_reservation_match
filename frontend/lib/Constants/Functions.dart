import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class UtilityFunctions {
  static void showErrorDialog(
      String title, String message, BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: message,
      btnOkOnPress: () {},
      width: deviceSize.width * 0.6,
    )..show();
  }

  static void showInfoDialog(
      String title, String message, BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    AwesomeDialog(
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: title,
      desc: message,
      btnOkOnPress: () {},
      width: deviceSize.width * 0.6,
    )..show();
  }
}
