/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'record_time_series.dart';
import 'label_widget.dart';

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

  static var _weightFormat = charts.BasicNumericTickFormatterSpec((num value) => '${value.toInt()} lbs');

  static charts.TextStyleSpec _lableStyleLight = charts.TextStyleSpec(
    fontSize: 10,
    color: charts.MaterialPalette.black,
  );

  static charts.TextStyleSpec _lableStyleDark = charts.TextStyleSpec(
    fontSize: 10,
    color: charts.MaterialPalette.white,
  );

  static charts.LineStyleSpec _yLineStyle = charts.LineStyleSpec(
    thickness: 0,
    // color: charts.MaterialPalette.gray.shadeDefault,
    color: charts.MaterialPalette.transparent, // Make the grid lines disappear
  );

  static charts.LineStyleSpec _xLineStyle = charts.LineStyleSpec(
    thickness: 0,
    color: charts.MaterialPalette.transparent, // Make the grid lines disappear
  );

  static var yAxisDarkTheme = charts.NumericAxisSpec(
    // Make the y-axis start from non-zero
    tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false,),
    tickFormatterSpec: _weightFormat,
    renderSpec: charts.GridlineRendererSpec(
      labelStyle: _lableStyleDark,
      lineStyle: _yLineStyle,
    ),
  );

  static var yAxisLightTheme = charts.NumericAxisSpec(
    // Make the y-axis start from non-zero
    tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false,),
    renderSpec: charts.GridlineRendererSpec(
      labelStyle: _lableStyleLight,
      lineStyle: _yLineStyle,
    ),
  );

  static var xAxisDarkTheme = charts.DateTimeAxisSpec(
    tickFormatterSpec: _dateStyle,
    renderSpec: charts.GridlineRendererSpec(
      labelStyle: _lableStyleDark,
      lineStyle: _xLineStyle,
    ),
  );

  static var xAxisLightTheme = charts.DateTimeAxisSpec(
    tickFormatterSpec: _dateStyle,
    renderSpec: charts.GridlineRendererSpec(
      labelStyle: _lableStyleLight,
      lineStyle: _xLineStyle,
    ),
  );

  List<List<TimeSeriesRecords>> parseRecords(records) {
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
    final parsedData = parseRecords(widget._records);

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
              flex: 15,
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
            SizedBox(height: 5),
            Flexible(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Label("Squat", Colors.red),
                  Label("Deadlift", Colors.blue),
                  Label("Press", Colors.yellow),
                  Label("Bench", Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
