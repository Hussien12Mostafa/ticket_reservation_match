import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/Constants/Endpoints.dart';
import 'package:worldcup/Models/Stadium.dart';
import 'package:worldcup/Models/Team.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/ViewModels/MatchesViewModel.dart';
import 'package:worldcup/ViewModels/StadiumsViewModel.dart';
import 'package:worldcup/ViewModels/TeamViewModel.dart';
import 'package:worldcup/Widgets/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Models/Match.dart';
import 'package:worldcup/Navigation/Locator.dart';
import 'package:worldcup/Navigation/NavigationService.dart';
import 'package:worldcup/Constants/Routes.dart' as routes;

class EditMatchFormWidget extends StatefulWidget {
  @override
  _EditMatchFormWidgetState createState() => _EditMatchFormWidgetState();
}

class _EditMatchFormWidgetState extends State<EditMatchFormWidget> {
    final NavigationService _navigationService = locator<NavigationService>();
  final TextEditingController homeTeamController = TextEditingController();
  final TextEditingController awayTeamController = TextEditingController();
  final TextEditingController staidumController = TextEditingController();
  final TextEditingController linesman1Controller = TextEditingController();
  final TextEditingController linesman2Controller = TextEditingController();
  final TextEditingController mainRefereeController = TextEditingController();
  final TextEditingController matchDateController = TextEditingController();
  final TextEditingController matchTimeController = TextEditingController();
  var deviceSize;

  List<Team> teams;
  var teamsProvider;
  var teamsProviderForLists;

  List<Stadium> stadiums;
  var stadiumsProvider;
  var stadiumsProviderForLists;

  var matchProvider;

  AuthenticationViewModel userProvider;

  var stadiumId;
  var homeTeamId;
  var awayTeamId;

  Match match;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    matchProvider = Provider.of<MatchesViewModel>(context, listen: false);
    userProvider = Provider.of<AuthenticationViewModel>(context, listen: false);

    match = matchProvider.getMatchToEdit;
    homeTeamController.text = match.homeTeam.name;
    homeTeamId = match.homeTeam.id;
    awayTeamController.text = match.awayTeam.name;
    awayTeamId = match.awayTeam.id;
    staidumController.text = match.matchVenue.name;
    stadiumId = match.matchVenue.id;
    linesman1Controller.text = match.linesman1;
    linesman2Controller.text = match.linesman2;
    mainRefereeController.text = match.mainReferee;
    matchDateController.text = match.date.split('T')[0];
    matchTimeController.text = (match.date.split('T')[1]).split('.')[0];

    teamsProvider = Provider.of<TeamsViewModel>(context, listen: false);
    stadiumsProvider = Provider.of<StadiumsViewModel>(context, listen: false);

    Future.microtask(() {
      teamsProvider.getTeams();
      stadiumsProvider.getStadiums();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    teamsProviderForLists = Provider.of<TeamsViewModel>(context, listen: true);
    ;
    stadiumsProviderForLists =
        Provider.of<StadiumsViewModel>(context, listen: true);
    teams = teamsProviderForLists.allTeams;
    stadiums = stadiumsProviderForLists.allStadiums;
    return teamsProvider.status == Status.loading
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: _formKey,
            child: Container(
              width: deviceSize.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldWidget(
                        controller: homeTeamController,
                        deviceSize: deviceSize,
                        isFieldEnabled: false,
                        labelText: "Home Team",
                        obscureText: false,
                        width: 2.05,
                      ),
                      TextFieldWidget(
                        controller: awayTeamController,
                        deviceSize: deviceSize,
                        isFieldEnabled: false,
                        labelText: "Away Team",
                        obscureText: false,
                        width: 2.05,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _stadiumTextField(staidumController, "Stadium"),
                      _matchDateTextfield(
                        matchDateController,
                        "Match Date",
                      ),
                      _matchTimeTextfield(
                        matchTimeController,
                        "Match Time",
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldWidget(
                        deviceSize: deviceSize,
                        controller: mainRefereeController,
                        labelText: 'Main Referee',
                        width: 2.05,
                      ),
                      TextFieldWidget(
                        deviceSize: deviceSize,
                        controller: linesman1Controller,
                        labelText: 'Linesman 1',
                        width: 2.05,
                      ),
                      TextFieldWidget(
                        deviceSize: deviceSize,
                        controller: linesman2Controller,
                        labelText: 'Linesman 2',
                        width: 2.05,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: ConstantColors.purple,
                          backgroundColor: ConstantColors.purple,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            if (linesman1Controller.text ==
                                linesman2Controller.text) {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.ERROR,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'Error',
                                  desc:
                                      'Please selecte different"Linesman 1" & "Linesman 1"',
                                  btnOkOnPress: () {},
                                  width: deviceSize.width * 0.4)
                                ..show();
                            } else if (homeTeamController.text ==
                                awayTeamController.text) {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.ERROR,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'Error',
                                  desc:
                                      'Please selecte different"Home" & "Away" teams',
                                  btnOkOnPress: () {},
                                  width: deviceSize.width * 0.4)
                                ..show();
                            } else {
                              try {
                                await matchProvider.editMatch(
                                    stadiumId,
                                    linesman1Controller.text,
                                    linesman2Controller.text,
                                    mainRefereeController.text,
                                    matchDateController.text,
                                    matchTimeController.text,
                                    match.id,
                                    userProvider.accessToken);
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.SUCCES,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'Success',
                                    desc: 'Match Edited Successfully',
                                    btnOkOnPress: () {},
                                    width: deviceSize.width * 0.4)
                                  ..show();
                                _navigationService.navigateToWithReplacement(
                                    routes.managerViewAllMatches);
                              } catch (error) {
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.ERROR,
                                    animType: AnimType.BOTTOMSLIDE,
                                    title: 'Error',
                                    desc: error.toString(),
                                    btnOkOnPress: () {},
                                    width: deviceSize.width * 0.4)
                                  ..show();
                              }
                            }
                          }
                        },
                        child: Text(
                          "Edit Match",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget _stadiumTextField(
      TextEditingController stadiumController, String labelText) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.white),
      child: Container(
        width: deviceSize.width * (0.4 / 2.07),
        height: deviceSize.height * 0.08,
        margin: EdgeInsets.all(deviceSize.height * 0.015),
        child: DropdownButtonFormField(
          items: stadiums
              .map(
                (stadium) => DropdownMenuItem(
                  child: Text(stadium.name),
                  value: stadium,
                ),
              )
              .toList(),
          onChanged: (value) {
            stadiumId = value.id;
            stadiumController.text = value.name;
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

  Widget _matchDateTextfield(
      TextEditingController controller, String labelText) {
    return Container(
      width: deviceSize.width * (0.4 / 2.05),
      height: deviceSize.height * 0.08,
      margin: EdgeInsets.all(deviceSize.height * 0.015),
      child: TextField(
        onTap: () async {
          final choice = await showDatePicker(
              context: context,
              firstDate: DateTime(1970),
              initialDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
              builder: (BuildContext context, Widget child) {
                return Center(
                    child: SizedBox(
                  width: deviceSize.width * 0.6,
                  height: deviceSize.height * 0.6,
                  child: child,
                ));
              });
          controller.text =
              choice != null ? DateFormat('yyyy-MM-dd').format(choice) : '';
        },
        controller: controller,
        enabled: true,
        enableInteractiveSelection: false,
        readOnly: true,
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
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _matchTimeTextfield(
      TextEditingController controller, String labelText) {
    return Container(
      width: deviceSize.width * (0.4 / 2.05),
      height: deviceSize.height * 0.08,
      margin: EdgeInsets.all(deviceSize.height * 0.015),
      child: TextField(
        onTap: () async {
          final choice = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (BuildContext context, Widget child) {
                return Center(
                    child: SizedBox(
                  width: deviceSize.width * 0.6,
                  height: deviceSize.height * 0.6,
                  child: child,
                ));
              });
          controller.text =
              choice != null ? choice.format(context).toString() : '';
        },
        controller: controller,
        enabled: true,
        enableInteractiveSelection: false,
        readOnly: true,
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
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
