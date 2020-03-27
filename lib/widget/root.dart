import 'package:coronavirus/api/data.dart';
import 'package:coronavirus/page/aboutme.dart';
import 'package:coronavirus/page/home.dart';
import 'package:coronavirus/page/stats.dart';
import 'package:flutter/material.dart';

class WidgetRoot extends StatefulWidget {
  WidgetRoot({Key key}) : super(key: key);

  @override
  _WidgetRootState createState() => _WidgetRootState();
}

class _WidgetRootState extends State<WidgetRoot> {
  Future<CountriesWithTotalData> _countriesWithTotalData;

  int _selectedIndex = 0;
  String _selectedTitle = "#StayAtHomeSaveLives";

  @override
  void initState() {
    super.initState();
    _countriesWithTotalData = startTransaction();
  }

  void _callback() {
    setState(() {
      _countriesWithTotalData = startTransaction();
    });
  }

  final List<String> _titles = <String>[
    '#StayAtHomeSaveLives',
    'Stats',
    'About Me'
  ];

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedTitle = _titles[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CountriesWithTotalData>(
      future: _countriesWithTotalData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If application didn't load data from service update splash widget
          if (snapshot.hasError) {
            return Scaffold(
              body: _splash(
                "Oops Something Wen't Wrong",
                snapshot.error.toString(),
                true,
                callback: _callback,
              ),
            );
          }

          // If application load data successfully show pages
          return _mainFrame(
            HomePage(
              countries: snapshot.data.countriesData.countries,
            ),
            StatsPage(
              totalData: snapshot.data.totalData,
              countries: snapshot.data.countriesData.countries,
            ),
          );

          // If process not done running show splash screen
        } else {
          return Scaffold(
            body: _splash("Welcome The Corona Virus Tracker",
                "Make sure internet connection is active", false),
          );
        }
      },
    );
  }

  Widget _mainFrame(HomePage _homePage, StatsPage _statsPage) {
    final List<Widget> _pages = <Widget>[
      _homePage,
      _statsPage,
      AboutMePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedTitle),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text("Stats"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text("About Me"),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

Widget _splash(String _headerText, String _paragraph, bool _isFailure,
        {Function callback}) =>
    Center(
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
                  image: AssetImage('graphics/hiker.png'),
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
                      _headerText,
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
                      _paragraph,
                      style: TextStyle(color: Colors.black87, fontSize: 15.0),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Visibility(
                      visible: !_isFailure,
                      child: CircularProgressIndicator(),
                    ),
                    Visibility(
                      visible: _isFailure,
                      child: Container(
                        width: 250.0,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            callback();
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
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
