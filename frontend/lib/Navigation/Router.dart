import 'package:worldcup/Views/AdminAllUsersView.dart';
import 'package:worldcup/Views/AdminView.dart';
import 'package:worldcup/Views/AddMatchView.dart';
import 'package:worldcup/Views/AddStadiumView.dart';
import 'package:worldcup/Views/EditMatchView.dart';
import 'package:worldcup/Views/Error404View.dart';
import 'package:worldcup/Views/GuestViewAllMatches.dart';
import 'package:worldcup/Views/LandingPage.dart';
import 'package:worldcup/Views/ManagerAllMatchesView.dart';
import 'package:worldcup/Views/MatchBookingView.dart';
import 'package:worldcup/Views/MyProfileView.dart';
import 'package:worldcup/Views/MyReservationsView.dart';
import 'package:worldcup/Views/SignInView.dart';
import 'package:worldcup/Views/SignUpView.dart';
import 'package:worldcup/Views/UserAllMatchesView.dart';
import 'package:flutter/material.dart';
import '../Constants/Routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case landingScreen:
      return _getPageRoute(LandingPageView(), settings);
    case signUp:
      return _getPageRoute(SignUpView(), settings);
    case signIn:
      return _getPageRoute(SignInView(), settings);
    case myProfile:
      return _getPageRoute(MyProfileView(), settings);
    case admin:
      return _getPageRoute(AdminView(), settings);
    case addMatch:
      return _getPageRoute(AddMatchView(), settings);
    case addStadium:
      return _getPageRoute(AddStadiumView(), settings);
    case managerViewAllMatches:
      return _getPageRoute(ManagerAllMatchesView(), settings);
    case adminAllUsers:
      return _getPageRoute(AdminAllUsersView(), settings);
    case editMatch:
      return _getPageRoute(EditMatchView(), settings);
    case userViewAllMatches:
      return _getPageRoute(UserAllMatchesView(), settings);
    case bookMatch:
      return _getPageRoute(MatchBookingView(), settings);
    case myReservations:
      return _getPageRoute(MyReservationsView(), settings);
    case guestViewAllMatches:
      return _getPageRoute(GuestAllMatchesView(), settings);
    default:
      return _getPageRoute(Error404View(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
