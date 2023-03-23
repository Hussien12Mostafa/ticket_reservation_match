import 'dart:async';
import 'dart:convert';
import 'package:worldcup/Constants/Endpoints.dart';
import 'package:worldcup/Models/Match.dart';
import 'package:worldcup/Services/HTTPException.dart';
import 'package:worldcup/Services/WebServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MatchesViewModel with ChangeNotifier {
  Status status = Status.success;
  List<Match> matches = [];
  Match matchToEdit;
  Match matchToBook;
  Timer refreshTimer;
  List<String> waitingSeats = [];
  var channel;
  List<Match> get allMatches {
    return matches;
  }

  List<String> get allWaitingSeats {
    return waitingSeats;
  }

  void addWaitingSeat(String seatId) {
    waitingSeats.add(seatId);
  }

  void removeWaitingSeat(String seatId) {
    waitingSeats.remove(seatId);
  }

  Match get getMatchToEdit {
    return matchToEdit;
  }

  void setMatchToEdit(Match match) async {
    matchToEdit = match;
  }

  Match get getMatchToBook {
    return matchToBook;
  }

  void deleteMatchToBook(Match match, String token) {
    channel.sink.add(
      jsonEncode(
        {
          "action": "disconnect",
          "matchId": match.id,
        },
      ),
    );
  }

  void setMatchToBook(Match match, String token) {
    waitingSeats = [];
    matchToBook = match;
    channel = WebSocketChannel.connect(
      Uri.parse("ws://tazkarti-clone.onrender.com"),
    );
    refreshTimer = Timer.periodic(
      Duration(seconds: 5),
      (timer) async {
        channel.sink.add(
          jsonEncode(
            {
              "action": "refresh",
              "matchId": match.id,
            },
          ),
        );
      },
    );
    var updatedSeatsReserved;
    channel.stream.listen((message) {
      Map<String, dynamic> json = jsonDecode(message);
      updatedSeatsReserved = parseString(json['reservedSeats']);
      if (json['matchId'] == matchToBook.id)
        matchToBook.reservedSeats = updatedSeatsReserved;
      notifyListeners();
    }).resume();
  }

  Future<void> getAllMatches() async {
    status = Status.loading;
    notifyListeners();
    try {
      matches.clear();
      final response = await WebServices().getAllMatches();
      for (int i = 0; i < response.length; i++) {
        Match match = Match.fromJson(response[i]);
        matches.add(match);
      }
      status = Status.success;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addMatch(
      String homeTeam,
      String awayTeam,
      String matchVenue,
      String mainReferee,
      String linesman1,
      String linesman2,
      String date,
      String time,
      String token) async {
    status = Status.loading;
    notifyListeners();
    try {
      await WebServices().addMatch(homeTeam, awayTeam, matchVenue, mainReferee,
          linesman1, linesman2, date, time, token);
      status = Status.success;
      notifyListeners();
    } catch (error) {
      status = Status.failed;
      throw HTTPException(error.toString());
    }
  }

  Future<void> editMatch(
      String matchVenue,
      String linesman1,
      String linesman2,
      String mainReferee,
      String date,
      String time,
      String id,
      String token) async {
    status = Status.loading;
    notifyListeners();
    try {
      await WebServices().editMatch(
          matchVenue, linesman1, linesman2, mainReferee, date, time, id, token);
      status = Status.success;
      notifyListeners();
    } catch (error) {
      status = Status.failed;
      throw HTTPException(error.toString());
    }
  }

  static List<String> parseString(stringJson) {
    List<String> stringList = new List<String>.from(stringJson);
    return stringList;
  }
}
