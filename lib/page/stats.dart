import 'package:charts_flutter/flutter.dart' as charts;
import 'package:coronavirus/bloc/bloc.dart';
import 'package:coronavirus/chart/CountryDataChart.dart';
import 'package:coronavirus/chart/TotalDataChart.dart';
import 'package:coronavirus/model/CountriesData.dart';
import 'package:coronavirus/model/CountriesWithTotalData.dart';
import 'package:coronavirus/model/TotalData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class StatsPage extends StatefulWidget {
  final CountriesWithTotalData cwtd = CountriesWithTotalData.instance;

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with AutomaticKeepAliveClientMixin<StatsPage> {
  _DropDownBloc _dropDownBloc = _DropDownBloc();
  Country _dropDownValue;

  @override
  void initState() {
    super.initState();
    _dropDownValue = widget.cwtd.countriesData.countries[0];
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      top: true,
      bottom: true,
      right: true,
      left: true,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //First Chart
            _drawTotalDataChart(),

            // Second Chart
            _drawCountryDataChart(),
          ],
        ),
      ),
    );
  }

  Widget _drawTotalDataChart() => Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Total Data",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(3.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Container(
                padding: EdgeInsets.only(right: 20.0, top: 10.0),
                height: 250,
                child: TotalDataChart.withData(
                  _createTotalDataChartSeries(
                    widget.cwtd.totalData,
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  Widget _drawCountryDataChart() => StreamBuilder(
        stream: _dropDownBloc.dropDownStream,
        builder: ((context, AsyncSnapshot<Country> snapshot) {
          if (snapshot.hasData) {
            _dropDownValue = snapshot.data;
          }
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Countries Data",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 8.0),
                      child: DropdownButton<Country>(
                        value: _dropDownValue,
                        icon: Icon(Icons.arrow_downward),
                        elevation: 16,
                        onChanged: (country) {
                          _dropDownBloc.addEvent(country);
                        },
                        items: widget.cwtd.countriesData.countries
                            .map<DropdownMenuItem<Country>>((c) {
                          return DropdownMenuItem<Country>(
                            value: c,
                            child: Text(c.toString()),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 16.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Container(
                    padding: EdgeInsets.only(right: 16.0, bottom: 8.0),
                    height: 300,
                    child: CountryDataChart.withData(
                      _createCountryDataChart(_dropDownValue),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      );

  @override
  void dispose() {
    _dropDownBloc.dispose();
    super.dispose();
  }
}

List<charts.Series<ChartData, String>> _createTotalDataChartSeries(
    TotalData totalData) {
  final _totalData = [
    new ChartData(
        "Deaths", num.parse(totalData.totalDeaths.replaceAll(',', ''))),
    new ChartData(
      'Cases',
      num.parse(totalData.totalCases.replaceAll(',', '')),
    ),
    new ChartData(
      'Recovered',
      num.parse(totalData.totalRecovered.replaceAll(',', '')),
    )
  ];

  return [
    charts.Series<ChartData, String>(
      id: 'TotalData',
      domainFn: (ChartData data, _) => data.domain,
      measureFn: (ChartData data, _) => data.measure,
      labelAccessorFn: (ChartData data, _) =>
          '${_convertStringToDouble(data.measure)}',
      data: _totalData,
    )
  ];
}

List<charts.Series<ChartData, String>> _createCountryDataChart(
    Country country) {
  final _countryData = [
    new ChartData(
      "Deaths",
      country.totalDeaths.isEmpty
          ? 0
          : num.parse(country.totalDeaths.replaceAll(',', '')),
    ),
    new ChartData(
      'Cases',
      country.totalCases.isEmpty
          ? 0
          : num.parse(country.totalCases.replaceAll(',', '')),
    ),
    new ChartData(
      'Recovered',
      country.totalRecovered.isEmpty
          ? 0
          : num.parse(country.totalRecovered.replaceAll(',', '')),
    )
  ];

  return [
    charts.Series<ChartData, String>(
      id: 'TotalData',
      domainFn: (ChartData data, _) => data.domain,
      measureFn: (ChartData data, _) => data.measure,
      labelAccessorFn: (ChartData data, _) =>
          '${data.domain}: ${_convertStringToDouble(data.measure)}',
      data: _countryData,
    )
  ];
}

class ChartData {
  final String domain;
  final num measure;

  ChartData(this.domain, this.measure);
}

_convertStringToDouble(num value) {
  var f = NumberFormat('###,###', 'en_US');
  return f.format(num.parse(value.toString()));
}

class _DropDownBloc extends Bloc<Country> {
  final _dropdownFetcher = PublishSubject<Country>();

  Observable<Country> get dropDownStream => _dropdownFetcher.stream;

  @override
  void addEvent(event) {
    try {
      _dropdownFetcher.sink.add(event);
    } catch (err) {
      addError(err);
    }
  }

  @override
  void addError(err) {
    _dropdownFetcher.sink.addError(err);
  }

  @override
  void dispose() {
    _dropdownFetcher.close();
  }
}
