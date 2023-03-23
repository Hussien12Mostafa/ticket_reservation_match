import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/Views/Error404View.dart';
import 'package:worldcup/Widgets/EditProfileFormWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/Colors.dart';
import '../Constants/Routes.dart';

class MyProfileView extends StatefulWidget {
  @override
  _MyProfileViewState createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
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
        body: auth.role == "fan"
            ? Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(height: 50),
                        EditProfileFormWidget(),
                      ],
                    ),
                  ),
                ],
              )
            : Error404View(),
      ),
    );
  }
}
