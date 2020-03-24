import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget {
  final Function callback;
  final String errorMessage;

  WidgetError({this.errorMessage, this.callback});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('graphics/error-404.png'),
                  width: 250,
                  height: 250,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Oops Something Wen't Wrong",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 32.0),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.black87, fontSize: 15.0),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 250.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      this.callback();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text(
                      "Try Again",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}