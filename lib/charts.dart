/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'record_time_series.dart';
import 'line_widget.dart';

class SimpleTimeSeriesChart extends StatefulWidget {
  final List<DataBaseRecords> _records;
  SimpleTimeSeriesChart(this._records);
  @override
  _SimpleTimeSeriesChartState createState() => _SimpleTimeSeriesChartState();
}

class _SimpleTimeSeriesChartState extends State<SimpleTimeSeriesChart> {
  static charts.TickFormatterSpec _dateStyle =
      charts.AutoDateTimeTickFormatterSpec(
    month: charts.TimeFormatterSpec(
      format: 'MM/yy',
      transitionFormat: 'MM/yy',
    ),
  );
  static charts.TextStyleSpec _lableStyleLight = charts.TextStyleSpec(
    fontSize: 10,
    color: charts.MaterialPalette.black,
  );

  static charts.TextStyleSpec _lableStyleDark = charts.TextStyleSpec(
    fontSize: 10,
    color: charts.MaterialPalette.white,
  );

  static charts.LineStyleSpec _lineStyle = charts.LineStyleSpec(
    thickness: 0,
    color: charts.MaterialPalette.gray.shadeDefault,
  );

  static var yAxisDarkTheme = charts.NumericAxisSpec(
    renderSpec: charts.GridlineRendererSpec(
      labelStyle: _lableStyleDark,
      lineStyle: _lineStyle,
    ),
  );

  var xAxisDarkTheme = charts.DateTimeAxisSpec(
    tickFormatterSpec: _dateStyle,
    renderSpec: charts.GridlineRendererSpec(
      labelStyle: _lableStyleDark,
      lineStyle: _lineStyle,
    ),
  );

  var yAxisLightTheme = charts.NumericAxisSpec(
    renderSpec: charts.GridlineRendererSpec(
      labelStyle: _lableStyleLight,
      lineStyle: _lineStyle,
    ),
  );

  var xAxisLightTheme = charts.DateTimeAxisSpec(
    tickFormatterSpec: _dateStyle,
    renderSpec: charts.GridlineRendererSpec(
      labelStyle: _lableStyleLight,
      lineStyle: _lineStyle,
    ),
  );

  List<List<TimeSeriesRecords>> parse_records(records) {
    // Convert DataBaseRecords into TimeSeriesRecords by making each record into
    // 4 records by seperating the different lifts
    List<TimeSeriesRecords> squatRecords = [];
    List<TimeSeriesRecords> benchRecords = [];
    List<TimeSeriesRecords> deadliftRecords = [];
    List<TimeSeriesRecords> pressRecords = [];

    for (var i = 0; i < records.length; i++) {
      DateTime date = records[i].date;
      TimeSeriesRecords squat = TimeSeriesRecords(date, records[i].squatMax);
      TimeSeriesRecords bench = TimeSeriesRecords(date, records[i].benchMax);
      TimeSeriesRecords deadlift =
          TimeSeriesRecords(date, records[i].deadliftMax);
      TimeSeriesRecords press = TimeSeriesRecords(date, records[i].pressMax);
      squatRecords.add(squat);
      benchRecords.add(bench);
      deadliftRecords.add(deadlift);
      pressRecords.add(press);
    }
    return [squatRecords, benchRecords, deadliftRecords, pressRecords];
  }

  @override
  Widget build(BuildContext context) {
    final parsedData = parse_records(widget._records);

    final seriesList = [
      /// Create one series with sample hard coded data.
      new charts.Series<TimeSeriesRecords, DateTime>(
        id: 'Bench', // This doesn't seeem to appear anywhere
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesRecords records, _) => records.time,
        measureFn: (TimeSeriesRecords records, _) => records.record,
        data: parsedData[1],
      ),
      new charts.Series<TimeSeriesRecords, DateTime>(
        id: 'Deadlift', // This doesn't seeem to appear anywhere
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesRecords records, _) => records.time,
        measureFn: (TimeSeriesRecords records, _) => records.record,
        data: parsedData[2],
      ),
      new charts.Series<TimeSeriesRecords, DateTime>(
        id: 'Squat', // This doesn't seeem to appear anywhere
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeriesRecords records, _) => records.time,
        measureFn: (TimeSeriesRecords records, _) => records.record,
        data: parsedData[0],
      ),
      new charts.Series<TimeSeriesRecords, DateTime>(
        id: 'Press', // This doesn't seeem to appear anywhere
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (TimeSeriesRecords records, _) => records.time,
        measureFn: (TimeSeriesRecords records, _) => records.record,
        data: parsedData[3],
      ),
    ];

    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        height: 400,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Label("Squat", Colors.red),
                  Expanded(child: SizedBox()),
                  Label("Deadlift", Colors.blue),
                ],
              ),
            ),
            SizedBox(height: 5),
            Flexible(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Label("Press", Colors.yellow),
                  Expanded(child: SizedBox()),
                  Label("Bench", Colors.green),
                ],
              ),
            ),
            Flexible(
              flex: 12,
              child: charts.TimeSeriesChart(
                seriesList,
                animate: true,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                domainAxis: Theme.of(context).brightness == Brightness.dark
                    ? xAxisDarkTheme
                    : xAxisLightTheme,
                primaryMeasureAxis:
                    Theme.of(context).brightness == Brightness.dark
                        ? yAxisDarkTheme
                        : yAxisLightTheme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
