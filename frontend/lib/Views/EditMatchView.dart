import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/Views/Error404View.dart';
import 'package:worldcup/Widgets/EditMatchFormWidget.dart';
import 'package:worldcup/Widgets/FooterWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/Colors.dart';
import '../Constants/Routes.dart';

class EditMatchView extends StatefulWidget {
  @override
  _EditMatchViewState createState() => _EditMatchViewState();
}

class _EditMatchViewState extends State<EditMatchView> {
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
                        SizedBox(height: 120),
                        EditMatchFormWidget(),
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
