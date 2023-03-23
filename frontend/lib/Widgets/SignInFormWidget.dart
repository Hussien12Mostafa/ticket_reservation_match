import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/Constants/Endpoints.dart';
import 'package:worldcup/Navigation/Locator.dart';
import 'package:worldcup/Navigation/NavigationService.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/Widgets/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldcup/Constants/Routes.dart' as routes;

class SignInFormWidget extends StatefulWidget {
  @override
  _SignInFormWidgetState createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var deviceSize;
  AuthenticationViewModel provider;
  AuthenticationViewModel providerListener;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    provider = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    providerListener =
        Provider.of<AuthenticationViewModel>(context, listen: true);
    deviceSize = MediaQuery.of(context).size;
    return providerListener.status == Status.loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _formKey,
            child: Container(
              width: deviceSize.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldWidget(
                    deviceSize: deviceSize,
                    controller: userNameController,
                    labelText: 'Username *',
                    width: 1,
                  ),
                  TextFieldWidget(
                    deviceSize: deviceSize,
                    controller: passwordController,
                    obscureText: true,
                    labelText: 'Password *',
                    width: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: ConstantColors.purple,
                      ),
                      onPressed: () async {
                        _formKey.currentState.validate();
                        await provider.signIn(
                          userNameController.text,
                          passwordController.text,
                          context,
                        );
                        if (provider.role == "admin") {
                          _navigationService
                              .navigateToWithReplacement(routes.admin);
                        } else if (provider.role == "manager") {
                          _navigationService.navigateToWithReplacement(
                              routes.managerViewAllMatches);
                        } else {
                          _navigationService.navigateToWithReplacement(
                              routes.userViewAllMatches);
                        }
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
