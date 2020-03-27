import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class TotalDataChart extends StatelessWidget {
  final List<charts.Series> series;

  TotalDataChart(this.series);

  factory TotalDataChart.withData(List<charts.Series> _series) {
    return TotalDataChart(_series);
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      series,
      animate: true,
      behaviors: [
        charts.DatumLegend(
          position: charts.BehaviorPosition.end,
          horizontalFirst: false,
          cellPadding: EdgeInsets.only(left: 4.0, right: 4.0),
          showMeasures: false,
        ),
      ],
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 60,
        arcRendererDecorators: [new charts.ArcLabelDecorator()],
      ),
    );
  }
}
