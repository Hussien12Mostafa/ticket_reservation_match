import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName,
      {Map<String, String> queryParams}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateToWithReplacement(String routeName,
      {Map<String, String> queryParams}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  Future<dynamic> navigateToWithReplacementUntilRoute(String routeName,
      {Map<String, String> queryParams}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }

  void popUntilRoute() {
    return navigatorKey.currentState.popUntil(ModalRoute.withName("/"));
  }
}
