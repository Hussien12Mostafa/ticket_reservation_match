import 'package:worldcup/Constants/Routes.dart';
import 'package:worldcup/Navigation/LayoutTemplate.dart';
import 'package:worldcup/ViewModels/MatchesViewModel.dart';
import 'package:worldcup/ViewModels/ReservationsViewModel.dart';
import 'package:worldcup/ViewModels/StadiumsViewModel.dart';
import 'package:worldcup/ViewModels/TeamViewModel.dart';
import 'package:worldcup/Views/Error404View.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Navigation/Router.dart' as router;
import 'Constants/Colors.dart';
import 'Navigation/Locator.dart';
import 'Navigation/NavigationService.dart';
import 'ViewModels/AdminViewModel.dart';
import 'ViewModels/AuthenticationViewModel.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthenticationViewModel(),
        ),
        ChangeNotifierProvider.value(
          value: AdminViewModel(),
        ),
        ChangeNotifierProvider.value(
          value: TeamsViewModel(),
        ),
        ChangeNotifierProvider.value(
          value: StadiumsViewModel(),
        ),
        ChangeNotifierProvider.value(
          value: MatchesViewModel(),
        ),
        ChangeNotifierProvider.value(value: ReservationsViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'worldcup',
        theme: ThemeData(
          primarySwatch: ConstantColors.purpleMaterial,
          fontFamily: 'EncodeSansExpanded',
        ),
        builder: (context, child) => LayoutTemplate(
          child: child,
          isSignedIn: true,
          background: true,
        ),
        onGenerateRoute: router.generateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => Error404View(
            name: settings.name,
          ),
        ),
        initialRoute: landingScreen,
      ),
    );
  }
}
