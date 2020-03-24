import 'package:coronavirus/api/client.dart';
import 'package:coronavirus/model/Api.dart';
import 'package:coronavirus/model/Country.dart';
import 'package:coronavirus/widget/error.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Api> _response;
  WebService webService = WebService();

  _HomePageState() {
    getApplicationToken().then((val) => setState(() {
          webService.token = val;
          _response = webService.fetchCountries();
        }));
  }

  _refreshState() {
    setState(() {
      _response = webService.fetchCountries();
    });
  }

  void _callback() {
    _refreshState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<Api>(
          future: _response,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return WidgetError(
                  errorMessage: snapshot.error
                      .toString()
                      .substring(snapshot.error.toString().indexOf(' ')),
                  callback: _callback,
                );
              }
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
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

_countryCard(List<Country> countries, int index) {
  return Card(
    elevation: 4.0,
    margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
    child: _countryListItem(countries[index].name),
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
