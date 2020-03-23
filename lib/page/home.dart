import 'package:flutter/material.dart';

import 'package:coronavirus/api/client.dart';
import 'package:coronavirus/model/Api.dart';
import 'package:coronavirus/model/Country.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WebService webService;

  _HomePageState() {
    getApplicationToken().then((val) => setState(() {
          webService = WebService(token: val);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<Api>(
          future: webService.fetchCountries(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return SomethingWentWrong(
                  errorMessage: snapshot.error.toString(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.countries.length,
                  itemBuilder: (context, index) {
                    return _countryCard(snapshot.data.countries, index);
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  final String errorMessage;

  SomethingWentWrong({this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
      child: Column(
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
                    "Oops Something Went't Wrong",
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
                  onPressed: () async {
                    await SystemNavigator.pop();
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
    );
  }
}

_countryCard(List<Country> countiries, int index) {
  return Card(
    elevation: 4.0,
    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
    child: _countryListItem(countiries[index].name),
  );
}

_countryListItem(String countryName) {
  return ListTile(
    contentPadding: EdgeInsets.fromLTRB(16, 2, 10, 0),
    title: Text(
      countryName,
      style: TextStyle(fontSize: 24),
      textAlign: TextAlign.center,
    ),
  );
}
