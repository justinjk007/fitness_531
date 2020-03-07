/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'record_time_series.dart';

class SimpleTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;

  SimpleTimeSeriesChart(this.seriesList);

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
    );
  }

  var yAxisDarkTheme = charts.NumericAxisSpec(
    renderSpec: charts.GridlineRendererSpec(
      labelStyle: charts.TextStyleSpec(
          fontSize: 10, color: charts.MaterialPalette.white),
      lineStyle: charts.LineStyleSpec(
          thickness: 0, color: charts.MaterialPalette.gray.shadeDefault),
    ),
  );

  var xAxisDarkTheme = charts.DateTimeAxisSpec(
    renderSpec: charts.GridlineRendererSpec(
      labelStyle: charts.TextStyleSpec(
        color: charts.MaterialPalette.white,
      ),
      lineStyle: charts.LineStyleSpec(
        color: charts.MaterialPalette.gray.shadeDefault,
      ),
    ),
  );

  var yAxisLightTheme = charts.NumericAxisSpec(
    renderSpec: charts.GridlineRendererSpec(
      labelStyle: charts.TextStyleSpec(
          fontSize: 10, color: charts.MaterialPalette.black),
      lineStyle: charts.LineStyleSpec(
          thickness: 0, color: charts.MaterialPalette.gray.shadeDefault),
    ),
  );

  var xAxisLightTheme = charts.DateTimeAxisSpec(
    renderSpec: charts.GridlineRendererSpec(
      labelStyle: charts.TextStyleSpec(
        color: charts.MaterialPalette.black,
      ),
      lineStyle: charts.LineStyleSpec(
        color: charts.MaterialPalette.gray.shadeDefault,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      domainAxis: Theme.of(context).brightness == Brightness.dark
          ? xAxisDarkTheme
          : xAxisLightTheme,
      primaryMeasureAxis: Theme.of(context).brightness == Brightness.dark
          ? yAxisDarkTheme
          : yAxisLightTheme,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesRecords, DateTime>> _createSampleData() {
    final data1 = [
      new TimeSeriesRecords(new DateTime(2017, 9, 19), 5),
      new TimeSeriesRecords(new DateTime(2017, 9, 26), 25),
      new TimeSeriesRecords(new DateTime(2017, 10, 3), 100),
      new TimeSeriesRecords(new DateTime(2017, 10, 11), 75),
      new TimeSeriesRecords(new DateTime(2017, 11, 26), 25),
    ];

    final data2 = [
      new TimeSeriesRecords(new DateTime(2017, 9, 19), 1),
      new TimeSeriesRecords(new DateTime(2017, 9, 26), 10),
      new TimeSeriesRecords(new DateTime(2017, 10, 3), 10),
      new TimeSeriesRecords(new DateTime(2017, 10, 11), 30),
      new TimeSeriesRecords(new DateTime(2017, 11, 26), 75),
    ];

    return [
      new charts.Series<TimeSeriesRecords, DateTime>(
        id: 'Squat',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesRecords sales, _) => sales.time,
        measureFn: (TimeSeriesRecords sales, _) => sales.record,
        data: data1,
      ),
      new charts.Series<TimeSeriesRecords, DateTime>(
        id: 'Bench',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesRecords sales, _) => sales.time,
        measureFn: (TimeSeriesRecords sales, _) => sales.record,
        data: data2,
      )
    ];
  }
}
