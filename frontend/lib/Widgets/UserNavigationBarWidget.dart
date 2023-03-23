import 'package:worldcup/Constants/Routes.dart' as routes;
import 'package:worldcup/Navigation/Locator.dart';
import 'package:worldcup/Navigation/NavigationService.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'NavBarItemWidget.dart';

class UserNavigationBarWidget extends StatefulWidget {
  UserNavigationBarWidget();
  @override
  _UserNavigationBarWidgetState createState() =>
      _UserNavigationBarWidgetState();
}

class _UserNavigationBarWidgetState extends State<UserNavigationBarWidget> {
  List _isHovering = [false, false, false, false];
  final NavigationService _navigationService = locator<NavigationService>();
  AuthenticationViewModel provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AuthenticationViewModel>(context, listen: true);
    return Container(
      height: 100,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(80, 0, 0, 0),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Image.asset(
                    'images/profileIcon.png',
                    height: 50,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome,',
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    Text(
                      provider.firstName + " " + provider.lastName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text('Username:  ',
                            style: TextStyle(color: Colors.grey, fontSize: 14)),
                        Text(
                          "@" + provider.userName,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: InkWell(
                  child: NavBarItem('Home', Icons.home_outlined, _isHovering[0],
                      Colors.black),
                  onTap: () {
                    _navigationService.navigateTo(routes.userViewAllMatches);
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
                    'Reservations',
                    Icons.apps_outlined,
                    _isHovering[1],
                    Colors.black87,
                  ),
                  onTap: () {
                    _navigationService.navigateTo(routes.myReservations);
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
