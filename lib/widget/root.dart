import 'package:coronavirus/page/home.dart';
import 'package:flutter/material.dart';

class WidgetRoot extends StatefulWidget {
  final String title;
  
  WidgetRoot({Key key, this.title}) : super(key: key);

  @override
  _WidgetRootState createState() => _WidgetRootState();
}

class _WidgetRootState extends State<WidgetRoot> {
  int _selectedIndex = 0;
  static List<Widget> _pages = <Widget>[
    HomePage(),
  ];

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text("Stats")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text("Info")
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}