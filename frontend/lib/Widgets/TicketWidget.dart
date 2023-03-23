import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:worldcup/Models/Reservation.dart';
import 'package:worldcup/Models/User.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/ViewModels/ReservationsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketWidget extends StatefulWidget {
  final Reservation reservation;
  final User user;

  TicketWidget({this.reservation, this.user});

  @override
  _TicketWidgetState createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  ReservationsViewModel reservationProvider;
  AuthenticationViewModel userProvider;
  var deviceSize;
  @override
  void initState() {
    reservationProvider =
        Provider.of<ReservationsViewModel>(context, listen: false);

    userProvider = Provider.of<AuthenticationViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: Center(
        child: FlutterTicketWidget(
          width: 400.0,
          height: 450.0,
          isCornerRounded: true,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    widget.reservation.match.homeTeam.name +
                        ' VS ' +
                        widget.reservation.match.awayTeam.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Column(
                    children: <Widget>[
                      ticketDetailsWidget(
                          'Name',
                          widget.user.firstName + " " + widget.user.lastName,
                          'Date',
                          widget.reservation.match.date.split('T')[0]),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0,right: 15.0),
                        child: ticketDetailsWidget(
                            'Stadium',
                            widget.reservation.match.matchVenue.name,
                            'Time',
                            widget.reservation.match.date.split('T')[1].split('.')[0]),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, right: 40.0),
                          child: ticketDetailsWidget(
                              'Ticket Number',
                              widget.reservation.id,
                              'Seat',
                              widget.reservation.seat)),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 70.0, right: 20.0),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(45, 0, 0, 0),
                    child: QrImage(
                      data: widget.reservation.id,
                      version: QrVersions.auto,
                      size: 100.0,
                    ),
                    width: 250.0,
                    height: 100.0,
                  ),
                ),
                DateFormat("yyyy-MM-dd")
                            .parse(widget.reservation.match.date)
                            .difference(DateFormat("yyyy-MM-dd")
                                .parse(DateTime.now().toString())) >=
                        Duration(days: 3)
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 70.0, right: 20.0),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(60, 0, 0, 0),
                          width: 80.0,
                          height: 30.0,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                                backgroundColor: Colors.red),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.QUESTION,
                                animType: AnimType.BOTTOMSLIDE,
                                btnOkText: 'Yes',
                                btnCancelOnPress: () {},
                                btnCancelText: 'No',
                                title: 'Are you sure?',
                                width: deviceSize.width * 0.4,
                                desc:
                                    'Are you sure you want to cancel the reservation for seat ' +
                                        widget.reservation.seat,
                                btnOkOnPress: () async {
                                  try {
                                    await reservationProvider.cancelReservation(
                                        widget.reservation,
                                        userProvider.accessToken);
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.SUCCES,
                                        animType: AnimType.BOTTOMSLIDE,
                                        title: 'Success',
                                        desc:
                                            'Reservation Cancelled Successfully',
                                        btnOkOnPress: () {},
                                        width: deviceSize.width * 0.4)
                                      ..show();
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
                                },
                              )..show();
                            },
                          ),
                          decoration: BoxDecoration(),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                secondTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  secondDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
