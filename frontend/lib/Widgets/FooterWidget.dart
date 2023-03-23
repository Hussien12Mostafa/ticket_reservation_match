import 'package:worldcup/Constants/Routes.dart' as routes;
import 'package:worldcup/Navigation/Locator.dart';
import 'package:worldcup/Navigation/NavigationService.dart';
import 'package:worldcup/Widgets/FooterItemWidget.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
  FooterWidget();
  @override
  _FooterWidgetState createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  List _isHovering = [false, false, false, false];
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(80, 0, 30, 0),
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
                  child: FooterItem('Home', _isHovering[0], Colors.white),
                  onTap: () {
                    _navigationService.navigateTo(routes.landingScreen);
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
                  child: FooterItem('About Us', _isHovering[1], Colors.white),
                  onTap: () {
                    _navigationService.navigateTo(routes.landingScreen);
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
              )
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(700, 0, 0, 0),
            child: Text(
              '© 2020 World Cup.',
              style: TextStyle(fontSize: 10, color: Colors.white60),
            ),
          ),
        ],
      ),
    );
  }
}
