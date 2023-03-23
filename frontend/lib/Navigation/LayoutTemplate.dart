import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/Widgets/AdminNavgationBarWidget.dart';
import 'package:worldcup/Widgets/ManagerNavigationBarWidget.dart';
import 'package:worldcup/Widgets/NavigationBarWidget.dart';
import 'package:worldcup/Widgets/UserNavigationBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LayoutTemplate extends StatefulWidget {
  final Widget child;
  final bool isSignedIn;
  final bool background;
  const LayoutTemplate({
    Key key,
    this.child,
    this.isSignedIn,
    this.background,
  }) : super(key: key);

  @override
  _LayoutTemplateState createState() => _LayoutTemplateState();
}

class _LayoutTemplateState extends State<LayoutTemplate> {
  AuthenticationViewModel provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AuthenticationViewModel>(context, listen: true);
    return Scaffold(
      body: Column(
        children: <Widget>[
          if (!provider.isAuth)
            NavigationBarWidget(
              signedIn: false,
              background: true,
            ),
          if (provider.isAuth && provider.role == "fan")
            NavigationBarWidget(
              signedIn: true,
              background: true,
            ),
          if (provider.role == "manager") ManagerNavigationBarWidget(),
          if (provider.role == "admin") AdminNavigationBarWidget(),
          if (provider.role == "fan") UserNavigationBarWidget(),
          Expanded(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
