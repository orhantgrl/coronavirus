import 'package:flutter/material.dart';

import 'package:coronavirus/bloc/countries_bloc.dart';
import 'package:coronavirus/model/CountriesData.dart';

class WidgetSplash extends StatefulWidget {
  @override
  _WidgetSplashState createState() => _WidgetSplashState();
}

class _WidgetSplashState extends State<WidgetSplash> {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllCountries();
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.allCountries,
        builder: (context, AsyncSnapshot<CountriesData> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error");
            }
            return Text("Wow Its Workingg");
          } else {
            return _splashBuilder(
              header: 'Application Is Loading',
              paragraph: 'Please make sure you have proper internet connection',
              widget: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _splashBuilder(
          {@required String header,
          @required String paragraph,
          @required Widget widget}) =>
      Center(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('graphics/hiker.png'),
                width: 250,
                height: 250,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  header,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 32.0),
                child: Text(
                  paragraph,
                  style: TextStyle(color: Colors.black87, fontSize: 15.0),
                ),
              ),
              widget
            ],
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
