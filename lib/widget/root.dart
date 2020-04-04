import 'package:coronavirus/bloc/countries_bloc.dart';
import 'package:coronavirus/bloc/totalData_bloc.dart';
import 'package:coronavirus/page/about_me.dart';
import 'package:coronavirus/page/home.dart';
import 'package:coronavirus/page/stats.dart';
import 'package:flutter/material.dart';

class WidgetRoot extends StatefulWidget {
  WidgetRoot({Key key}) : super(key: key);

  @override
  _WidgetRootState createState() => _WidgetRootState();
}

class _WidgetRootState extends State<WidgetRoot> {
  int _selectedIndex = 0;
  String _selectedTitle = "#StayAtHomeSaveLives";

  _WidgetRootState() {
    countriesBloc.fetchCountries();
    totalDataBloc.fetchTotalData();
  }

  final List<String> _titles = <String>[
    '#StayAtHomeSaveLives',
    'Stats',
    'About Me'
  ];

  final List<Widget> _pages = <Widget>[
    HomePage(),
    StatsPage(),
    AboutMePage(),
  ];

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedTitle = _titles[index];
    });
  }

  @override
  Widget build(BuildContext context) {
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

  @override
  void dispose() {
    countriesBloc.dispose();
    totalDataBloc.dispose();
    super.dispose();
  }
}
