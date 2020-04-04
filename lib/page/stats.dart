import 'package:charts_flutter/flutter.dart' as charts;
import 'package:coronavirus/chart/TotalDataChart.dart';
import 'package:coronavirus/model/CountriesWithTotalData.dart';
import 'package:coronavirus/model/TotalData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with AutomaticKeepAliveClientMixin<StatsPage> {
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
      child: Column(
        children: <Widget>[
          //First Chart
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
                      CountriesWithTotalData.instance.totalData),
                ),
              ),
            ),
          ),

          // Second Chart
          Padding(
            padding: EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Countries Data",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 8.0),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<charts.Series<ChartTotalData, String>> _createTotalDataChartSeries(
    TotalData totalData) {
  final _totalData = [
    new ChartTotalData(
        "Deaths", num.parse(totalData.totalDeaths.replaceAll(',', ''))),
    new ChartTotalData(
      'Cases',
      num.parse(totalData.totalCases.replaceAll(',', '')),
    ),
    new ChartTotalData(
      'Recovered',
      num.parse(totalData.totalRecovered.replaceAll(',', '')),
    )
  ];

  return [
    charts.Series<ChartTotalData, String>(
      id: 'TotalData',
      domainFn: (ChartTotalData data, _) => data.domain,
      measureFn: (ChartTotalData data, _) => data.measure,
      labelAccessorFn: (ChartTotalData data, _) =>
          '${_convertStringToDouble(data.measure)}',
      data: _totalData,
    )
  ];
}

class ChartTotalData {
  final String domain;
  final num measure;

  ChartTotalData(this.domain, this.measure);
}

_convertStringToDouble(num value) {
  var f = NumberFormat('###,###', 'en_US');
  return f.format(num.parse(value.toString()));
}
