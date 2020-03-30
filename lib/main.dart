import 'package:coronavirus/widget/splash.dart';
import 'package:flutter/material.dart';

void main() => runApp(Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona Virus Tracker',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(
              primaryColor: Colors.black,
              accentColor: Colors.deepPurple),
      home: WidgetSplash(),
    );
  }
}