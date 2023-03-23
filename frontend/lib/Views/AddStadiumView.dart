import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/Views/Error404View.dart';
import 'package:worldcup/Widgets/AddStadiumFormWidget.dart';
import 'package:worldcup/Widgets/FooterWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/Colors.dart';
import '../Constants/Routes.dart';

class AddStadiumView extends StatefulWidget {
  @override
  _AddStadiumViewState createState() => _AddStadiumViewState();
}

class _AddStadiumViewState extends State<AddStadiumView> {
  AuthenticationViewModel auth;
  @override
  void initState() {
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, signUp);
        return false;
      },
      child: Scaffold(
        backgroundColor: ConstantColors.grey,
        body: auth.role == "manager"
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(50, 50, 0, 0),
                          child: Text(
                            'Add Stadium',
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                        SizedBox(height: 80),
                        AddStadiumFormWidget(),
                      ],
                    ),
                  ),
                  FooterWidget()
                ],
              )
            : Error404View(),
      ),
    );
  }
}
