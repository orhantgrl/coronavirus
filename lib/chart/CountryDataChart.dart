import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/widgets.dart';

class CountryDataChart extends StatelessWidget {
  final List<charts.Series> series;

  CountryDataChart(this.series);

  factory CountryDataChart.withData(List<charts.Series> _series) {
    return CountryDataChart(_series);
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      series,
      animate: true,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
    );
  }
}
