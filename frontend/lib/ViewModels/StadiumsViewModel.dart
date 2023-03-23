import 'dart:async';
import 'package:worldcup/Constants/Endpoints.dart';
import 'package:worldcup/Models/Stadium.dart';
import 'package:worldcup/Services/HTTPException.dart';
import 'package:worldcup/Services/WebServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StadiumsViewModel with ChangeNotifier {
  Status status = Status.success;
  List<Stadium> stadiums = [];

  List<Stadium> get allStadiums {
    return stadiums;
  }

  Future<void> getStadiums() async {
    status = Status.loading;
    notifyListeners();
    try {
      stadiums.clear();
      final response = await WebServices().getStadiums();
      for (int i = 0; i < response.length; i++) {
        final stadium = Stadium.fromJson(response[i]);
        stadiums.add(stadium);
      }
      status = Status.success;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addStadium(
      String name, int rows, int numberOfSeatsPerRow, String token) async {
    status = Status.loading;
    notifyListeners();
    try {
      final response = await WebServices()
          .addStadium(name, rows, numberOfSeatsPerRow, token);
      status = Status.success;
      stadiums.add(Stadium.fromJson(response));
      notifyListeners();
    } catch (error) {
      status = Status.failed;
      throw HTTPException(error.toString());
    }
  }
}
