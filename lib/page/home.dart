import 'package:coronavirus/api/client.dart';
import 'package:coronavirus/model/Api.dart';
import 'package:flutter/material.dart';

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
                return Center(
                  child: Text("Oops someting went't wrong"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.countries.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 8.0,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        child: ListTile(
                            contentPadding: EdgeInsets.fromLTRB(16, 2, 10, 0),
                            title: Text(
                              '${snapshot.data.countries[index].name}',
                              style: TextStyle(fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Container(
                                padding: EdgeInsets.fromLTRB(0, 25, 0, 16),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text('Total Cases'),
                                            Text(
                                                '${snapshot.data.countries[index].totalCases}')
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('New Cases'),
                                            Text(
                                                '${snapshot.data.countries[index].newCases}')
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('Total Deaths'),
                                            Text(
                                                '${snapshot.data.countries[index].totalDeaths}')
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text('New Deaths'),
                                            Text(
                                                '${snapshot.data.countries[index].newDeaths}')
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              Text('Total Recovered'),
                                              Text(
                                                  '${snapshot.data.countries[index].totalRecovered}')
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text('Active Cases'),
                                              Text(
                                                  '${snapshot.data.countries[index].activeCases}')
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ))),
                      ),
                    );
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
