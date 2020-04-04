import 'package:coronavirus/bloc/countries_bloc.dart';
import 'package:coronavirus/bloc/totalData_bloc.dart';
import 'package:coronavirus/model/CountriesData.dart';
import 'package:coronavirus/model/CountriesWithTotalData.dart';
import 'package:coronavirus/model/TotalData.dart';
import 'package:coronavirus/widget/root.dart';
import 'package:flutter/material.dart';

class WidgetSplash extends StatefulWidget {
  @override
  _WidgetSplashState createState() => _WidgetSplashState();
}

class _WidgetSplashState extends State<WidgetSplash> {
  final cwd = CountriesWithTotalData.instance;

  _WidgetSplashState() {
    countriesBloc.fetchCountries();
    totalDataBloc.fetchTotalData();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: countriesBloc.countriesData,
      builder: ((context, AsyncSnapshot<CountriesData> snapshot) {
        return StreamBuilder(
          stream: totalDataBloc.totalData,
          builder: ((context, AsyncSnapshot<TotalData> snapshot1) {
            if (snapshot.hasError && snapshot1.hasError) {
              countriesBloc.fetchCountries();
              totalDataBloc.fetchTotalData();
              return _drawBody(
                header: "An error occurred. Please Check your connection.",
              );
            } else if (snapshot.hasData && snapshot1.hasData) {
              cwd.countriesData = snapshot.data;
              cwd.totalData = snapshot1.data;
              dispose();
              return WidgetRoot();
            } else {
              return _drawBody(
                header: "Fetching importants data from internet",
              );
            }
          }),
        );
      }),
    );
  }

  @override
  void dispose() {
    countriesBloc.dispose();
    totalDataBloc.dispose();
    super.dispose();
  }
}

Widget _drawBody({@required String header}) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('graphics/hiker.png'),
              width: 250,
              height: 250,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
              child: Text(
                header,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
