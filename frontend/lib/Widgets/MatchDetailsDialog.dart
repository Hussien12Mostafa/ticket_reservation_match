import 'package:flutter/material.dart';
import '../Models/Match.dart';

class MatchDetailsDialog extends StatelessWidget {
  final Match match;
  MatchDetailsDialog({this.match});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            match.homeTeam.name + " VS " + match.awayTeam.name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            match.matchVenue.name,
            style: TextStyle(fontSize: 20.0, color: Colors.grey),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Main Referee:',
                    style: TextStyle(
                        fontSize: 16.0,
                        // fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  Text(
                    match.mainReferee,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Linesmen:',
                    style: TextStyle(
                        fontSize: 16.0,
                        // fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  Text(
                    match.linesman1,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  Text(
                    match.linesman2,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Date & Time:',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey),
                  ),
                  Text(
                    match.date.split('T')[0],
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  Text(
                    (match.date.split('T')[1]).split('.')[0],
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Seats Reserved:',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey),
                  ),
                  Container(
                      child: Row(
                    children: [
                      Text(match.reservedSeats.length.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: match.reservedSeats.length.toDouble() /
                                        match.allSeats.length <
                                    0.3
                                ? Colors.purple
                                : match.reservedSeats.length.toDouble() /
                                            match.allSeats.length <
                                        0.7
                                    ? Colors.yellow
                                    : match.reservedSeats.length.toDouble() /
                                                match.allSeats.length ==
                                            1
                                        ? Colors.red
                                        : Colors.orange,
                          )),
                      Text(
                        '/' + match.allSeats.length.toString(),
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  )),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
