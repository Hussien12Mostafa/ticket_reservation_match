import 'package:worldcup/Constants/Endpoints.dart';
import 'package:worldcup/Constants/Functions.dart';
import 'package:worldcup/Models/User.dart';
import 'package:worldcup/Services/WebServices.dart';
import 'package:flutter/cupertino.dart';

class AdminViewModel with ChangeNotifier {
  List<User> _pendingUsers = [];
  List<User> _allUsers = [];
  Status status = Status.success;
  List<User> get getPendingUsers {
    return _pendingUsers;
  }

  List<User> get getAllUsers {
    return _allUsers;
  }

  Future<void> fetchPendingUsers(String token, BuildContext context) async {
    try {
      status = Status.loading;
      notifyListeners();
      final pendingUsers = await WebServices().fetchPendingUsers(token);
      _pendingUsers.clear();
      for (int i = 0; i < pendingUsers.length; i++) {
        User temp = User.fromJson(pendingUsers[i]);
        _pendingUsers.add(temp);
      }
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
    }
  }

  Future<void> fetchAllUsers(String token, BuildContext context) async {
    try {
      status = Status.loading;
      notifyListeners();
      final allUsers = await WebServices().fetchAllUsers(token);
      _allUsers.clear();
      for (int i = 0; i < allUsers.length; i++) {
        User temp = User.fromJson(allUsers[i]);
        _allUsers.add(temp);
      }
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
    }
  }

  Future<bool> updatePending(String token, String userId, bool accepted) async {
    try {
      bool request = await WebServices().updatePending(token, userId, accepted);
      _pendingUsers.removeWhere((user) => user.id == userId);
      notifyListeners();
      return request;
    } catch (error) {
      throw error;
    }
  }

  Future<bool> deleteUser(String token, String userId) async {
    try {
      bool request = await WebServices().deleteUser(token, userId);
      _allUsers.removeWhere((user) => user.id == userId);
      notifyListeners();
      return request;
    } catch (error) {
      throw error;
    }
  }

  Future<bool> updateAllPending(String token, bool accepted) async {
    try {
      bool request = await WebServices().updateAllPending(token, accepted);
      _pendingUsers.clear();
      notifyListeners();
      return request;
    } catch (error) {
      throw error;
    }
  }
}
