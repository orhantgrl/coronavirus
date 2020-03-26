import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _drawHeader(),
                _drawBody(),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _drawHeader() => Container(
      color: Colors.black,
      height: 200,
      child: Column(
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('graphics/avatar.jpeg'),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 15.0),
              padding: EdgeInsets.fromLTRB(16.0, 3.0, 16.0, 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(45.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "Orhan Tugrul",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Mobile & Backend Developer",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget _drawBody() => Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(16.0, 3.0, 16.0, 20.0),
            child: Text(
              "A software developer studying at Avrasya University and seeking no reason to be happy." +
                  " Java language lover and a fan of low-level languages.",
              style: TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.instagram,
                      size: 32.0,
                    ),
                    onPressed: () {
                      _launchURL('https://www.instagram.com/orhan.tgrl/');
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.twitter,
                      size: 32.0,
                    ),
                    onPressed: () {
                      _launchURL('https://twitter.com/thetgrl');
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.github,
                      size: 32.0,
                    ),
                    onPressed: () {
                      _launchURL('https://github.com/orhantgrl');
                    },
                  ),
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.linkedin,
                    size: 32.0,
                  ),
                  onPressed: () {
                    _launchURL('https://www.linkedin.com/in/orhantgrl/');
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 28.0),
            width: 250.0,
            height: 50.0,
            child: RaisedButton(
              onPressed: () {
                _launchURL("mailto:orhan.tugrul.61@gmail.com");
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45.0),
              ),
              color: Colors.black,
              textColor: Colors.white,
              child: Text(
                "Send Mail To Me",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );

_launchURL(final String uri) async {
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
