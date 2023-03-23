import 'dart:async';
import 'package:worldcup/Constants/Endpoints.dart';
import 'package:worldcup/Constants/Functions.dart';
import 'package:worldcup/Models/User.dart';
import 'package:worldcup/Services/WebServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationViewModel with ChangeNotifier {
  String _accessToken = " ";
  Status status = Status.success;
  User user;
  AuthenticationViewModel({this.user});
  bool get isAuth {
    return !(_accessToken == " ");
  }

  String get accessToken {
    return _accessToken;
  }

  String get id {
    return user.id;
  }

  String get userName {
    return user.userName;
  }

  String get firstName {
    return user.firstName;
  }

  String get lastName {
    return user.lastName;
  }

  String get nationality {
    return user.nationality;
  }

  String get dateOfBirth {
    return user.dateOfBirth;
  }

  String get gender {
    return user.gender;
  }

  String get email {
    return user.email;
  }

  String get role {
    if (user == null) {
      return " ";
    } else {
      return user.role;
    }
  }

  Future<void> signUp(
    String firstName,
    String lastName,
    String email,
    String userName,
    String password,
    String passwordConfrimation,
    String gender,
    String role,
    String dateOfBirth,
    String nationality,
    BuildContext context,
  ) async {
    status = Status.loading;
    notifyListeners();
    try {
      await WebServices().signUp(firstName, lastName, email, userName, password,
          passwordConfrimation, gender, role, dateOfBirth, nationality);
      UtilityFunctions.showInfoDialog(
        'Welcome to World Cup',
        'Your account is under review and will be accepted soon....',
        context,
      );
      status = Status.success;
      notifyListeners();
    } catch (error) {
      status = Status.failed;
      notifyListeners();
      UtilityFunctions.showErrorDialog(
        'An error occured',
        error.toString(),
        context,
      );
      throw Exception;
    }
  }

  Future<void> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    status = Status.loading;
    notifyListeners();
    try {
      await WebServices().changePassword(
          oldPassword, newPassword, confirmPassword, _accessToken);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(
    String username,
    String password,
    BuildContext context,
  ) async {
    try {
      status = Status.loading;
      notifyListeners();
      final Map<String, dynamic> results =
          await WebServices().signIn(username, password);
      await _cacheAndSetUserAuthenticationData(results);
      status = Status.success;
      notifyListeners();
    } catch (error) {
      status = Status.failed;
      notifyListeners();
      if (error.toString() == "Not Accepted Yet") {
        UtilityFunctions.showInfoDialog(
            'Welcome to World Cup',
            "Your account is still under review and will be accepted soon...",
            context);
      } else {
        UtilityFunctions.showErrorDialog(
            'An error occured', error.toString(), context);
      }

      throw Exception;
    }
  }

  Future<void> editProfile(
      String email,
      String firstName,
      String lastName,
      String dateOfBirth,
      String gender,
      String userName,
      String nationality) async {
    try {
      await WebServices().editProfile(
          firstName, lastName, dateOfBirth, gender, nationality, _accessToken);

      user.firstName = firstName;
      user.lastName = lastName;
      user.dateOfBirth = dateOfBirth;
      user.gender = gender;
      user.nationality = nationality;

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> _cacheAndSetUserAuthenticationData(
    Map<String, dynamic> userData,
  ) async {
    try {
      _accessToken = userData['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("accessToken", _accessToken);
      user = User.fromJson(userData['user']);
    } catch (error) {
      throw error;
    }
  }

  Future<void> checkCachedToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("accessToken")) {
        _accessToken = prefs.getString("accessToken");
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> setMyProfile() async {
    try {
      final Map<String, dynamic> results =
          await WebServices().fetchMyProfile(_accessToken);
      user = User.fromJson(results['data']['data']);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signOut() async {
    await WebServices().signOut(_accessToken);
    user = null;
    _accessToken = " ";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }
}
