/// Sample time series data type to store each record when plotting the charts
class TimeSeriesRecords {
  final DateTime time;
  final int record;
  TimeSeriesRecords(this.time, this.record);
}

class DataBaseRecords {
  final DateTime date;
  final int squatMax;
  final int benchMax;
  final int deadliftMax;
  final int pressMax;
  DataBaseRecords(
    this.date,
    this.squatMax,
    this.benchMax,
    this.deadliftMax,
    this.pressMax,
  );

  static DataBaseRecords fromMap(Map<String, dynamic> data) {
    var date = data['date'].toString();
    var dateParsed = DateTime(
      int.parse(date.substring(0, 4)),
      int.parse(date.substring(4, 6)),
      int.parse(date.substring(6, 8)),
    );

    return DataBaseRecords(
      dateParsed,
      data['squat'],
      data['bench'],
      data['deadlift'],
      data['press'],
    );
  }
}
