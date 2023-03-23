import 'package:worldcup/Models/Stadium.dart';
import 'package:worldcup/Models/Team.dart';

class Match {
  final String id;
  Team homeTeam;
  Team awayTeam;
  Stadium matchVenue;
  String date;
  String mainReferee;
  String linesman1;
  String linesman2;
  List<String> reservedSeats;
  List<String> allSeats;
  Match(
      {this.id,
      this.homeTeam,
      this.awayTeam,
      this.matchVenue,
      this.date,
      this.mainReferee,
      this.linesman1,
      this.linesman2,
      this.reservedSeats,
      this.allSeats});
  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['match']['_id'],
      homeTeam: Team.fromJson(json['match']['firstTeam']),
      awayTeam: Team.fromJson(json['match']['secondTeam']),
      matchVenue: Stadium.fromJson(json['match']['stadium']),
      date: json['match']['startDate'],
      mainReferee: json['match']['mainReferee'],
      linesman1: json['match']['firstLineman'],
      linesman2: json['match']['secondLineman'],
      reservedSeats: parseString(json['reservedSeats']),
      allSeats: parseString(json['allSeats']),
    );
  }

  static List<String> parseString(stringJson) {
    List<String> stringList = new List<String>.from(stringJson);
    return stringList;
  }
}
