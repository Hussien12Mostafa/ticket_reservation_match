import 'package:worldcup/Navigation/Locator.dart';
import 'package:worldcup/Navigation/NavigationService.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/Colors.dart';
import '../Constants/Routes.dart';
import 'package:worldcup/Constants/Routes.dart' as routes;

class LandingPageView extends StatefulWidget {
  @override
  _LandingPageViewState createState() => _LandingPageViewState();
}

class _LandingPageViewState extends State<LandingPageView> {
  final NavigationService _navigationService = locator<NavigationService>();
  List _isHovering = [false, false, false, false];
  AuthenticationViewModel userProvider;
  AuthenticationViewModel userProvider2;
  @override
  void initState() {
    userProvider2 =
        Provider.of<AuthenticationViewModel>(context, listen: false);

    userProvider2.checkCachedToken().then((value) {
      if (userProvider2.accessToken != " ") {
        userProvider2.setMyProfile();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<AuthenticationViewModel>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/stadium.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      'Choose Your Next Match',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Explore and book all matched',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 150,
                          width: 150,
                          child: InkWell(
                            onTap: () {},
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
                            child: InkWell(
                              onTap: () {
                                if (userProvider.role == " " ||
                                    userProvider.role == "admin") {
                                  _navigationService
                                      .navigateTo(routes.guestViewAllMatches);
                                } else if (userProvider.role == "manager") {
                                  _navigationService
                                      .navigateTo(routes.managerViewAllMatches);
                                } else if (userProvider.role == "fan") {
                                  _navigationService
                                      .navigateTo(routes.userViewAllMatches);
                                }
                              },
                              child: Card(
                                color: _isHovering[0]
                                    ? ConstantColors.purple.withOpacity(0.9)
                                    : ConstantColors.purple.withOpacity(0.7),
                                child: Column(
                                  children: [
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 20, 0, 10),
                                        height: 80,
                                        width: 80,
                                        child: Image.asset(
                                            'images/stadiumIcon.png')),
                                    Text(
                                      'Matches',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  if (!userProvider.isAuth)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 65,
                        ),
                        InkWell(
                          onTap: () {
                            _navigationService.navigateTo(signIn);
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
                          child: Text(
                            'Sign in    ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _isHovering[1]
                                    ? Colors.white70
                                    : Colors.white),
                          ),
                        ),
                        Text(
                          '     Or     ',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            _navigationService.navigateTo(signUp);
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
                          child: Container(
                            height: 50,
                            width: 150,
                            child: Card(
                              color: _isHovering[2]
                                  ? ConstantColors.purple.withOpacity(1)
                                  : ConstantColors.purple.withOpacity(0.8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person_add,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Register Now',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(0, 100, 0, 20),
                    child: Text(
                      '© 2020 World Cup.',
                      style: TextStyle(fontSize: 10, color: Colors.white60),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
