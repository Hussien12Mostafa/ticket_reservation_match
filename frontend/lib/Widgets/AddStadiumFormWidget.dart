import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/ViewModels/StadiumsViewModel.dart';
import 'package:worldcup/Widgets/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddStadiumFormWidget extends StatefulWidget {
  @override
  _AddStadiumFormWidgetState createState() => _AddStadiumFormWidgetState();
}

class _AddStadiumFormWidgetState extends State<AddStadiumFormWidget> {
  final TextEditingController stadiumNameController = TextEditingController();
  final TextEditingController numberOfRowsController = TextEditingController();
  final TextEditingController seatsPerRowController = TextEditingController();
  var deviceSize;
  var stadiumProvider;

  AuthenticationViewModel userProvider;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    stadiumProvider = Provider.of<StadiumsViewModel>(context, listen: false);
    userProvider = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }

    if (int.tryParse(s) == null) {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Error',
          desc: 'Number of rows and number of seats per row should be a number',
          btnOkOnPress: () {},
          width: deviceSize.width * 0.4)
        ..show();
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Container(
          width: deviceSize.width * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFieldWidget(
                deviceSize: deviceSize,
                controller: stadiumNameController,
                labelText: 'Stadium Name',
                width: 1,
              ),
              TextFieldWidget(
                deviceSize: deviceSize,
                controller: numberOfRowsController,
                labelText: 'Number Of Rows',
                width: 1,
              ),
              TextFieldWidget(
                deviceSize: deviceSize,
                controller: seatsPerRowController,
                labelText: 'Number Of Seats Per Row',
                width: 1,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: ConstantColors.purple,
                      backgroundColor: ConstantColors.purple,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate() &&
                          isNumeric(seatsPerRowController.text) &&
                          isNumeric(numberOfRowsController.text)) {
                        try {
                          await stadiumProvider.addStadium(
                              stadiumNameController.text,
                              int.parse(numberOfRowsController.text),
                              int.parse(seatsPerRowController.text),
                              userProvider.accessToken);
                          stadiumNameController.clear();
                          numberOfRowsController.clear();
                          seatsPerRowController.clear();
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.SUCCES,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Success',
                              desc: 'Stadium Added Successfully',
                              btnOkOnPress: () {},
                              width: deviceSize.width * 0.4)
                            ..show();
                  
                        } catch (error) {
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Error',
                              desc: error.toString(),
                              btnOkOnPress: () {},
                              width: deviceSize.width * 0.4)
                            ..show();
                        }
                      }
                    },
                    child: Text(
                      "Add Stadium",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
