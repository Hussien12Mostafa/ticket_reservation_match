import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/Constants/Endpoints.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/ViewModels/MatchesViewModel.dart';
import 'package:worldcup/Views/Error404View.dart';
import 'package:worldcup/Widgets/FooterWidget.dart';
import 'package:worldcup/Widgets/MatchListTileWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Models/Match.dart';

class ManagerAllMatchesView extends StatefulWidget {
  @override
  _ManagerAllMatchesViewState createState() => _ManagerAllMatchesViewState();
}

class _ManagerAllMatchesViewState extends State<ManagerAllMatchesView> {
  final TextEditingController sortController = TextEditingController();

  List<Match> matches;
  var matchesProvider;
  var matchesProviderForLists;
  AuthenticationViewModel auth;
  @override
  void initState() {
    matchesProvider = Provider.of<MatchesViewModel>(context, listen: false);
    Future.microtask(() {
      matchesProvider.getAllMatches();
    });
    auth = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    matchesProviderForLists =
        Provider.of<MatchesViewModel>(context, listen: true);
    matches = matchesProviderForLists.allMatches;
    if (sortController.text.isNotEmpty) {
      matches.sort((a, b) {
        return DateFormat("yyyy-MM-dd")
            .parse(a.date)
            .compareTo(DateFormat("yyyy-MM-dd").parse(b.date));
      });
      if (sortController.text == 'Newest to Oldest') {
        matches = matches.reversed.toList();
      } else {}
    }

    return Scaffold(
      backgroundColor: ConstantColors.grey,
      body: auth.role == "manager"
          ? Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      children: [
                        Row(
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
                            _sortTextField(sortController, 'Sort', deviceSize)
                          ],
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
                                                return MatchListTileWidget(
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
                        FooterWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Error404View(),
    );
  }

  Widget _sortTextField(
      TextEditingController sortController, String labelText, Size deviceSize) {
    return Container(
      width: deviceSize.width * 0.15,
      height: deviceSize.height * 0.08,
      margin: EdgeInsets.all(deviceSize.height * 0.015),
      child: DropdownButtonFormField(
        items: ['Newest to Oldest', 'Oldest to Newest']
            .map(
              (label) => DropdownMenuItem(
                child: Text(label),
                value: label,
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            sortController.text = value;
          });
        },
        value: 'Newest to Oldest',
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
    );
  }
}
