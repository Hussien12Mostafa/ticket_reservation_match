import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/Views/Error404View.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/Colors.dart';
import '../Widgets/SignUpFormWidget.dart';
import '../Constants/Routes.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
        body: auth.role == " "
            ? Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          height: 100,
                          width: double.infinity,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "Sign up for World Cup Tickets Account",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                child: Text(
                                  "Fill in all the required fields marked by (*).",
                                  style: TextStyle(
                                    color: Colors.red[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 0,
                          thickness: 2,
                          color: ConstantColors.purple,
                        ),
                        SizedBox(height: 50),
                        SignUpFormWidget(),
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
