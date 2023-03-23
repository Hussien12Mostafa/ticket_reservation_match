import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/Constants/Endpoints.dart';
import 'package:worldcup/Models/Team.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/ViewModels/MatchesViewModel.dart';
import 'package:worldcup/ViewModels/TeamViewModel.dart';
import 'package:worldcup/Views/Error404View.dart';
import 'package:worldcup/Widgets/FooterWidget.dart';
import 'package:worldcup/Widgets/UserMatchTileWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/Match.dart';

class UserAllMatchesView extends StatefulWidget {
  @override
  _UserAllMatchesViewState createState() => _UserAllMatchesViewState();
}

class _UserAllMatchesViewState extends State<UserAllMatchesView> {
  final TextEditingController teamController = TextEditingController();
  AuthenticationViewModel auth;
  List<Match> matches;
  var matchesProvider;
  var matchesProviderForLists;
  var deviceSize;

  List<Team> teams;
  var teamsProvider;
  var teamsProviderForLists;

  var teamId;

  @override
  void initState() {
    matchesProvider = Provider.of<MatchesViewModel>(context, listen: false);
    teamsProvider = Provider.of<TeamsViewModel>(context, listen: false);
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    Future.microtask(() {
      teamsProvider.getTeams();
      matchesProvider.getAllMatches();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    matchesProviderForLists =
        Provider.of<MatchesViewModel>(context, listen: true);
    teamsProviderForLists = Provider.of<TeamsViewModel>(context, listen: true);
    matches = matchesProviderForLists.allMatches;
    teams = teamsProviderForLists.allTeams;
    if (teamController.text.isNotEmpty) {
      matches = matches.where((match) {
        if (match.homeTeam.name == teamController.text ||
            match.awayTeam.name == teamController.text) {
          return true;
        }
        return false;
      }).toList();
    }
    return Scaffold(
      backgroundColor: ConstantColors.grey,
      body: auth.role == "fan"
          ? Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 30, 0, 20),
                                  child: Text(
                                    "Matches",
                                    style: TextStyle(
                                        fontSize: 40, color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(width: deviceSize.width * 0.6),
                              _teamsTextField(teamController, 'Team')
                            ],
                          ),
                        ),
                        matchesProviderForLists.status == Status.loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                margin: EdgeInsets.fromLTRB(
                                    deviceSize.width * 0.2,
                                    0,
                                    deviceSize.width * 0.2,
                                    0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[500],
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                ),
                                height: deviceSize.height * 0.7,
                                width: deviceSize.width * 0.8,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: deviceSize.height * 0.7,
                                    width: deviceSize.width * 0.8,
                                    child: matches.length != 0
                                        ? Scrollbar(
                                            child: ListView.builder(
                                              itemCount: matches.length,
                                              itemBuilder: (context, index) {
                                                return UserMatchListTileWidget(
                                                  match: matches[index],
                                                );
                                              },
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                              'No Matches Found',
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 28),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 50,
                        ),
                        FooterWidget()
                      ],
                    ),
                  ),
                )
              ],
            )
          : Error404View(),
    );
  }

  Widget _teamsTextField(
      TextEditingController teamController, String labelText) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.white),
      child: Container(
        width: deviceSize.width * (0.4 / 2.07),
        height: deviceSize.height * 0.08,
        margin: EdgeInsets.all(deviceSize.height * 0.015),
        child: DropdownButtonFormField(
          items: teams
              .map(
                (team) => DropdownMenuItem(
                  child: Text(team.name),
                  value: team,
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              teamId = value.id;
              teamController.text = value.name;
            });
          },
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            labelText: labelText,
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ConstantColors.purple, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[900], width: 1.0),
            ),
          ),
        ),
      ),
    );
  }
}
