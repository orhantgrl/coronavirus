import 'package:coronavirus/api/client.dart';
import 'package:coronavirus/model/CountriesData.dart';
import 'package:coronavirus/model/Country.dart';
import 'package:coronavirus/widget/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  Future<CountriesData> _response;
  WebService webService = WebService();

  @override
  void initState() {
    super.initState();
    getApplicationToken().then((val) => setState(() {
          webService.token = val;
          _response = webService.fetchCountriesData();
        }));
  }

  @override
  bool get wantKeepAlive => true;

  void _callback() {
    setState(() {
      _response = webService.fetchCountriesData();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      top: true,
      bottom: true,
      right: true,
      left: true,
      child: FutureBuilder<CountriesData>(
        future: _response,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return WidgetError(
                errorMessage: snapshot.error.toString(),
                callback: _callback,
              );
            }
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.countries.length,
              itemBuilder: ((context, index) {
                return _countryCardBuilder(snapshot.data.countries, index);
              }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Widget _countryCardBuilder(List<Country> countries, int index) => Card(
      clipBehavior: Clip.antiAlias,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(),
        child: _countryCardListTileBuilder(countries, index),
      ),
    );

Widget _countryCardListTileBuilder(List<Country> countries, int index) =>
    Column(
      children: <Widget>[
        // Header
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(14.0),
                color: Colors.black26,
                child: Text(
                  countries[index].name,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),

        // First Row
        Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    'graphics/virus.svg',
                    width: 24.0,
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(countries[index].totalCases.isEmpty
                        ? "None"
                        : countries[index].totalCases),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    'graphics/skull.svg',
                    width: 24.0,
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(countries[index].totalDeaths.isEmpty
                        ? "None"
                        : countries[index].totalDeaths),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    'graphics/new.svg',
                    width: 24.0,
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(countries[index].newCases.isEmpty
                        ? "None"
                        : countries[index].newCases),
                  )
                ],
              ),
            ],
          ),
        ),

        // Second Row
        Container(
          padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    'graphics/death.svg',
                    width: 24.0,
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(countries[index].newDeaths.isEmpty
                        ? "None"
                        : countries[index].newDeaths),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    'graphics/recover.svg',
                    width: 24.0,
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(countries[index].totalRecovered.isEmpty
                        ? "None"
                        : countries[index].totalRecovered),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    'graphics/cough.svg',
                    width: 24,
                    height: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(countries[index].activeCases.isEmpty
                        ? "None"
                        : countries[index].activeCases),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
