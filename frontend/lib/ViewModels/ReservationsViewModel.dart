import 'dart:async';
import 'package:worldcup/Constants/Endpoints.dart';
import 'package:worldcup/Models/Reservation.dart';
import 'package:worldcup/Services/WebServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReservationsViewModel with ChangeNotifier {
  Status status = Status.success;
  List<Reservation> reservations = [];
  bool validCreditCardData = false;

  List<Reservation> get allReservations {
    return reservations;
  }

  bool get creditCardValidity {
    return validCreditCardData;
  }

  void setValidity(bool isValid) {
    validCreditCardData = isValid;
  }

  Future<void> getAllReservations(String token) async {
    status = Status.loading;
    notifyListeners();
    try {
      reservations.clear();
      final response = await WebServices().getAllReservations(token);
      for (int i = 0; i < response.length; i++) {
        Reservation reservation = Reservation.fromJson((response[i]));
        reservations.add(reservation);
      }
      reservations = reservations.reversed.toList();
      status = Status.success;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> bookTickets(
      List<String> seatsIds, String token, String matchId) async {
    status = Status.loading;
    notifyListeners();
    try {
      reservations.clear();
      await WebServices().bookTickets(seatsIds, token, matchId);
      status = Status.success;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> cancelReservation(Reservation reservation, String token) async {
    status = Status.loading;
    notifyListeners();
    try {
      reservations.clear();
      await WebServices().cancelReservation(reservation, token);
      status = Status.success;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
