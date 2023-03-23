import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/ViewModels/MatchesViewModel.dart';
import 'package:worldcup/ViewModels/ReservationsViewModel.dart';
import 'package:worldcup/Views/Error404View.dart';
import 'package:worldcup/Widgets/CreditCardWidgetDialog.dart';
import 'package:worldcup/Widgets/FooterWidget.dart';
import 'package:worldcup/Widgets/SeatWidget.dart';
import 'package:flutter/material.dart';
import 'package:worldcup/Navigation/NavigationService.dart';
import 'package:provider/provider.dart';
import 'package:worldcup/Navigation/Locator.dart';
import '../Constants/Colors.dart';
import 'package:worldcup/Constants/Routes.dart' as routes;

class MatchBookingView extends StatefulWidget {
  @override
  _MatchBookingViewState createState() => _MatchBookingViewState();
}

class _MatchBookingViewState extends State<MatchBookingView> {
  MatchesViewModel matchProvider;
  MatchesViewModel matchProviderToListen;
  var match;

  ReservationsViewModel reservationProvider;
  AuthenticationViewModel userProvider;
  final NavigationService _navigationService = locator<NavigationService>();

  double _crossAxisSpacing = 5;
  double _mainAxisSpacing = 5;
  double _aspectRatio = 1;
  int _crossAxisCount;
  double _widthNeeded;

  List<String> waitingSeats;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    matchProvider = Provider.of<MatchesViewModel>(context, listen: false);
    reservationProvider =
        Provider.of<ReservationsViewModel>(context, listen: false);
    userProvider = Provider.of<AuthenticationViewModel>(context, listen: false);
    match = matchProvider.getMatchToBook;
    _crossAxisCount = match.matchVenue.columns;
    _widthNeeded = match.matchVenue.columns * 70.0;

    super.initState();
  }

  @override
  void dispose() {
    matchProvider.deleteMatchToBook(match, userProvider.id);
    matchProvider.refreshTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Size deviceSize = MediaQuery.of(context).size;

    matchProviderToListen =
        Provider.of<MatchesViewModel>(context, listen: true);
    match = matchProviderToListen.getMatchToBook;
    waitingSeats = matchProviderToListen.allWaitingSeats;
    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, routes.signUp);
        return false;
      },
      child: Scaffold(
        backgroundColor: ConstantColors.grey,
        body: userProvider.role == "fan"
            ? Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      child: ListView(
                        children: [
                          Container(
                            height: 100,
                            width: screenWidth - 150,
                            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                            child: Card(
                              color: Colors.green,
                              child: Center(
                                child: Text(
                                  'FIELD',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 500,
                            width: width,
                            padding: EdgeInsets.fromLTRB(
                                (deviceSize.width - _widthNeeded) / 2,
                                0,
                                (deviceSize.width - _widthNeeded) / 2,
                                0),
                            child: GridView.builder(
                              itemCount: matchProviderToListen
                                  .getMatchToBook.allSeats.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: match.matchVenue.columns,
                                childAspectRatio: _aspectRatio,
                                crossAxisSpacing: _crossAxisSpacing,
                                mainAxisSpacing: _mainAxisSpacing,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return SeatWidget(
                                  seatID: match.allSeats[index],
                                  status: match.reservedSeats
                                          .contains(match.allSeats[index])
                                      ? SeatStatus.Booked
                                      : waitingSeats
                                              .contains(match.allSeats[index])
                                          ? SeatStatus.Waiting
                                          : SeatStatus.Available,
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 50),
                          Container(
                            height: 50,
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  deviceSize.width * 0.4,
                                  0,
                                  deviceSize.width * 0.4,
                                  0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: ConstantColors.purple,
                                  backgroundColor: ConstantColors.purple,
                                ),
                                child: Text(
                                  'Book',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  reservationProvider.setValidity(false);
                                  AwesomeDialog(
                                      context: context,
                                      animType: AnimType.SCALE,
                                      dialogType: DialogType.INFO,
                                      body: CreditCardWidgetDialog(),
                                      btnOkText: 'Confirm',
                                      btnCancelText: 'Cancel',
                                      width: deviceSize.width * 0.4,
                                      title: 'This is Ignored',
                                      desc: 'This is also Ignored',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () async {
                                        try {
                                          if (reservationProvider
                                              .validCreditCardData) {
                                            await reservationProvider
                                                .bookTickets(
                                              waitingSeats,
                                              userProvider.accessToken,
                                              matchProvider.matchToBook.id,
                                            );
                                            AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.SUCCES,
                                                animType: AnimType.BOTTOMSLIDE,
                                                title: 'Success',
                                                desc:
                                                    'Tickets Booked Successfully',
                                                btnOkOnPress: () {},
                                                width: deviceSize.width * 0.4)
                                              ..show();
                                            _navigationService
                                                .navigateToWithReplacement(
                                                    routes.myReservations);
                                          } else {
                                            throw HttpException(
                                                'Invalid Credit Card Data');
                                          }
                                        } catch (error) {
                                          AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.ERROR,
                                              animType: AnimType.BOTTOMSLIDE,
                                              title: 'Error',
                                              desc: error
                                                  .toString()
                                                  .split(':')[1],
                                              btnOkOnPress: () {},
                                              width: deviceSize.width * 0.4)
                                            ..show();
                                        }
                                      })
                                    ..show();
                                },
                              ),
                            ),
                          ),
                          FooterWidget()
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Error404View(),
      ),
    );
  }
}
