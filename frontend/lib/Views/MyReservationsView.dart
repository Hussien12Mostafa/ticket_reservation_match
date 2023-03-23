import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/Models/Reservation.dart';
import 'package:worldcup/ViewModels/AuthenticationViewModel.dart';
import 'package:worldcup/ViewModels/ReservationsViewModel.dart';
import 'package:worldcup/Views/Error404View.dart';
import 'package:worldcup/Widgets/TicketWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyReservationsView extends StatefulWidget {
  @override
  _MyReservationsViewState createState() => _MyReservationsViewState();
}

class _MyReservationsViewState extends State<MyReservationsView> {
  final TextEditingController sortController = TextEditingController();

  List<Reservation> reservations;
  var reservationsProvider;
  var reservationsProviderForLists;

  AuthenticationViewModel userProvider;
  @override
  void initState() {
    userProvider = Provider.of<AuthenticationViewModel>(context, listen: false);
    reservationsProvider =
        Provider.of<ReservationsViewModel>(context, listen: false);
    Future.microtask(() {
      reservationsProvider.getAllReservations(userProvider.accessToken);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    reservationsProviderForLists =
        Provider.of<ReservationsViewModel>(context, listen: true);

    reservations = reservationsProviderForLists.allReservations;
    return Scaffold(
      backgroundColor: ConstantColors.grey,
      body: userProvider.role == "fan"
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30, 0, 20),
                        child: Text(
                          "My Reservations",
                          style: TextStyle(fontSize: 40, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: reservations.length == 0
                      ? Center(child: Text('No Reservations Yet'))
                      : Scrollbar(
                          child: ListView.builder(
                            itemCount: reservations.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (index > 0 &&
                                  reservations[index].match.id !=
                                      reservations[index - 1].match.id) {
                                return Row(
                                  children: [
                                    Container(
                                        height: deviceSize.height * 0.6,
                                        child: VerticalDivider(
                                          color: Colors.grey[500],
                                          thickness: 1.0,
                                        )),
                                    TicketWidget(
                                      reservation: reservations[index],
                                      user: userProvider.user,
                                    )
                                  ],
                                );
                              } else {
                                return TicketWidget(
                                  reservation: reservations[index],
                                  user: userProvider.user,
                                );
                              }
                            },
                          ),
                        ),
                ),
              ],
            )
          : Error404View(),
    );
  }
}
