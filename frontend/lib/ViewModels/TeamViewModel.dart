import 'dart:async';
import 'package:worldcup/Constants/Endpoints.dart';
import 'package:worldcup/Models/Team.dart';
import 'package:worldcup/Services/WebServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamsViewModel with ChangeNotifier {
  Status status = Status.success;
  List<Team> teams = [];

  List<Team> get allTeams {
    return teams;
  }

  Future<void> getTeams() async {
    status = Status.loading;
    notifyListeners();
    try {
      final response = await WebServices().getTeams();
      for (int i = 0; i < response.length; i++) {
        final team = Team.fromJson(response[i]);
        allTeams.add(team);
      }
      status = Status.success;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
