import 'package:worldcup/ViewModels/ReservationsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';

class CreditCardWidgetDialog extends StatefulWidget {
  @override
  _CreditCardWidgetDialogState createState() => _CreditCardWidgetDialogState();
}

class _CreditCardWidgetDialogState extends State<CreditCardWidgetDialog> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ReservationsViewModel reservationProvider;

  @override
  void initState() {
    reservationProvider =
        Provider.of<ReservationsViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      child: Expanded(
        child: ListView(
          children: <Widget>[
            CreditCardWidget(
              height: 200,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
            ),
            Container(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  onCreditCardModelChange: onCreditCardModelChange,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      if (creditCardModel.cardHolderName.isEmpty ||
          creditCardModel.cardNumber.length < 16 ||
          creditCardModel.cvvCode.length < 3 ||
          creditCardModel.expiryDate.length < 5) {
        reservationProvider.setValidity(false);
      } else {
        int month = int.parse(creditCardModel.expiryDate.split('/')[0]);
        int year = int.parse(creditCardModel.expiryDate.split('/')[1]);
        int currentYear =
            int.parse(DateTime.now().year.toString().substring(2));
        int currentMonth = DateTime.now().month.toInt();
        reservationProvider.setValidity(true);
        if (month > 12 || month < 1) {
          reservationProvider.setValidity(false);
        } else if (year == currentYear) {
          if (month < currentMonth) {
            reservationProvider.setValidity(false);
          }
        } else if (year < currentYear) {
          reservationProvider.setValidity(false);
        }
      }
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
