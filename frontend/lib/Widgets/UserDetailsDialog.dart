import 'package:worldcup/Models/User.dart';
import 'package:flutter/material.dart';

class UserDetailsDialog extends StatelessWidget {
  final User user;
  UserDetailsDialog({this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            user.firstName + " " + user.lastName,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Username: " + "@" + user.userName,
            style: TextStyle(fontSize: 20.0, color: Colors.grey),
          ),
          Text(
            "Role: " + user.role,
            style: TextStyle(fontSize: 20.0, color: Colors.blue),
          ),
          Text(
            "Email: " + user.email,
            style: TextStyle(fontSize: 20.0, color: Colors.grey),
          ),
          Text(
            "Nationality: " + user.nationality,
            style: TextStyle(fontSize: 20.0, color: Colors.grey),
          ),
          Text(
            "Gender: " + user.gender,
            style: TextStyle(fontSize: 20.0, color: Colors.grey),
          ),
          Text(
            "Date of birth: " + user.dateOfBirth.split('T')[0],
            style: TextStyle(fontSize: 20.0, color: Colors.grey),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
