import 'package:flutter/material.dart';

class Error404View extends StatelessWidget {
  final String name;
  const Error404View({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text('ERROR 404',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 50),
              width: 200,
              child: Image.asset('assets/images/var.png'),
            ),
            Container(
              child: Text(
                  'Unforutnately, after review this page is not found...',
                  style: TextStyle(color: Colors.black, fontSize: 28)),
            )
          ],
        ),
      ),
    );
  }
}
