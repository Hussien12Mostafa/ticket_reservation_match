import 'package:worldcup/Models/Match.dart';

class Reservation {
  final String id;
  Match match;
  String user;
  String seat;

  Reservation({this.id, this.match, this.user, this.seat});
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['ticket']['_id'],
      match: Match.fromJson(json['match']),
      user: json['ticket']['user'],
      seat: json['ticket']['seatID'],
    );
  }
}
