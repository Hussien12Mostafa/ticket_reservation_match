import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/ViewModels/MatchesViewModel.dart';
import 'package:worldcup/Widgets/MatchDetailsDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/Match.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class GuestMatchListTileWidget extends StatefulWidget {
  final Match match;
  GuestMatchListTileWidget({this.match});
  @override
  _GuestMatchListTileWidgetState createState() =>
      _GuestMatchListTileWidgetState();
}

class _GuestMatchListTileWidgetState extends State<GuestMatchListTileWidget> {
  var matchProvider;
  AuthenticationViewModel authenticationProvider;
  @override
  void initState() {
    matchProvider = Provider.of<MatchesViewModel>(context, listen: false);
    authenticationProvider =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(widget.match.date.split('T')[0],
                      style: TextStyle(color: Colors.grey)),
                  Text((widget.match.date.split('T')[1]).split('.')[0],
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
              Column(
                children: [
                  Text(
                    widget.match.homeTeam.name +
                        "  VS  " +
                        widget.match.awayTeam.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.match.matchVenue.name,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: Text(
                    "View Details",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    AwesomeDialog(
                        context: context,
                        animType: AnimType.SCALE,
                        dialogType: DialogType.INFO,
                        body: MatchDetailsDialog(
                          match: widget.match,
                        ),
                        width: deviceSize.width * 0.6,
                        title: 'This is Ignored',
                        desc: 'This is also Ignored',
                        btnCancelOnPress: () {},
                        btnCancelText: 'Close')
                      ..show();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: ConstantColors.purple,
                    backgroundColor: ConstantColors.purple,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
