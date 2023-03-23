import 'package:worldcup/Constants/Colors.dart';
import 'package:worldcup/ViewModels/MatchesViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum SeatStatus { Booked, Available, Waiting }

class SeatWidget extends StatefulWidget {
  SeatStatus status;
  final String seatID;
  SeatWidget({
    this.status,
    this.seatID,
  });
  @override
  _SeatWidgetState createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  bool _isHovering = false;
  var status;
  var matchProvider;
  @override
  void initState() {
    matchProvider = Provider.of<MatchesViewModel>(context, listen: false);
    status = widget.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    status = widget.status;
    return SizedBox(
      width: 50,
      height: 50,
      child: InkWell(
        onTap: () {
          if (status == SeatStatus.Available) {
            setState(() {
              matchProvider.addWaitingSeat(widget.seatID);
              widget.status = SeatStatus.Waiting;
            });
          } else if (status == SeatStatus.Waiting) {
            setState(() {
              matchProvider.removeWaitingSeat(widget.seatID);
              widget.status = SeatStatus.Available;
            });
          }
        },
        onHover: (isHovering) {
          setState(() {
            _isHovering = isHovering;
          });
        },
        child: Card(
          color: _isHovering
              ? status == SeatStatus.Available
                  ? ConstantColors.purple.withOpacity(0.7)
                  : status == SeatStatus.Waiting
                      ? Colors.yellow[700]
                      : Colors.red[700]
              : status == SeatStatus.Available
                  ? ConstantColors.purple
                  : status == SeatStatus.Waiting
                      ? Colors.yellow
                      : Colors.red,
          child: Center(
              child: Text(
            widget.seatID,
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
    );
  }
}
