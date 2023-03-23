import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/Constants/Routes.dart' as routes;
import 'package:worldcup/Navigation/Locator.dart';
import 'package:worldcup/Navigation/NavigationService.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'NavBarItemWidget.dart';

class NavigationBarWidget extends StatefulWidget {
  final bool background;
  final bool signedIn;
  NavigationBarWidget({
    this.background,
    this.signedIn,
  });
  @override
  _NavigationBarWidgetState createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  List _isHovering = [false, false, false, false];
  AuthenticationViewModel userProvider;
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    userProvider = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: widget.background ? ConstantColors.purple : Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(80, 0, 0, 0),
            child: Column(
              children: [
                widget.background
                    ? Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Image.asset(
                          'images/logo.png',
                          height: 60,
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Image.asset(
                          'images/logo.png',
                          height: 60,
                        ),
                      ),
              ],
            ),
          ),
          widget.signedIn
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: InkWell(
                        child: NavBarItem('My Profile', Icons.person,
                            _isHovering[0], Colors.white),
                        onTap: () {
                          _navigationService.navigateTo(routes.myProfile);
                        },
                        onHover: (isHovering) {
                          if (isHovering) {
                            setState(() {
                              _isHovering[0] = true;
                            });
                          } else {
                            setState(() {
                              _isHovering[0] = false;
                            });
                          }
                        },
                      ),
                    ),
                    Container(
                      child: InkWell(
                        child: NavBarItem('Sign Out', Icons.logout,
                            _isHovering[1], Colors.white),
                        onTap: () async {
                          await userProvider.signOut();
                          _navigationService.popUntilRoute();
                        },
                        onHover: (isHovering) {
                          if (isHovering) {
                            setState(() {
                              _isHovering[1] = true;
                            });
                          } else {
                            setState(() {
                              _isHovering[1] = false;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    )
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: InkWell(
                        child: NavBarItem('Register', Icons.person,
                            _isHovering[0], Colors.white),
                        onTap: () {
                          _navigationService.navigateTo(routes.signUp);
                        },
                        onHover: (isHovering) {
                          if (isHovering) {
                            setState(() {
                              _isHovering[0] = true;
                            });
                          } else {
                            setState(() {
                              _isHovering[0] = false;
                            });
                          }
                        },
                      ),
                    ),
                    Container(
                      child: InkWell(
                        child: NavBarItem('Sign In', Icons.lock_open,
                            _isHovering[1], Colors.white),
                        onTap: () {
                          _navigationService.navigateTo(routes.signIn);
                        },
                        onHover: (isHovering) {
                          if (isHovering) {
                            setState(() {
                              _isHovering[1] = true;
                            });
                          } else {
                            setState(() {
                              _isHovering[1] = false;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
