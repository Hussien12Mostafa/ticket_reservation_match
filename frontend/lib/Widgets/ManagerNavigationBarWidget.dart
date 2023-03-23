import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/Constants/Routes.dart' as routes;
import 'package:worldcup/Navigation/Locator.dart';
import 'package:worldcup/Navigation/NavigationService.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'NavBarItemWidget.dart';

class ManagerNavigationBarWidget extends StatefulWidget {
  ManagerNavigationBarWidget();
  @override
  _ManagerNavigationBarWidgetState createState() =>
      _ManagerNavigationBarWidgetState();
}

class _ManagerNavigationBarWidgetState
    extends State<ManagerNavigationBarWidget> {
  AuthenticationViewModel provider;

  List _isHovering = [false, false, false, false];
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  void initState() {
    provider = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: ConstantColors.purple,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(80, 0, 0, 0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Image.asset(
                    'images/logo.png',
                    height: 60,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: InkWell(
                  child: NavBarItem(
                      'Add Match', Icons.add, _isHovering[0], Colors.white),
                  onTap: () {
                    _navigationService.navigateTo(routes.addMatch);
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
                  child: NavBarItem(
                      'Add Stadium', Icons.add, _isHovering[1], Colors.white),
                  onTap: () {
                    _navigationService.navigateTo(routes.addStadium);
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
              Container(
                child: InkWell(
                  child: NavBarItem('View All Matches', Icons.apps,
                      _isHovering[2], Colors.white),
                  onTap: () {
                    _navigationService.navigateTo(routes.managerViewAllMatches);
                  },
                  onHover: (isHovering) {
                    if (isHovering) {
                      setState(() {
                        _isHovering[2] = true;
                      });
                    } else {
                      setState(() {
                        _isHovering[2] = false;
                      });
                    }
                  },
                ),
              ),
              Container(
                child: InkWell(
                  child: NavBarItem(
                    'Sign out',
                    Icons.group,
                    _isHovering[0],
                    Colors.white,
                  ),
                  onTap: () async {
                    await provider.signOut();
                    _navigationService.popUntilRoute();
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
