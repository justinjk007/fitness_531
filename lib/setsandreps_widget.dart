import 'package:flutter/material.dart';
import 'plates_and_bar.dart';
import 'save_state.dart';
import 'calc.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    Key key,
    this.argTitle,
    this.subTitle,
    this.setWeight,
  }) : super(key: key);

  final String argTitle;
  final String subTitle;
  final double setWeight;

  Widget getPlatesWidget(double weight, BuildContext ctxt) {
    PlatesAndBar commonSetup = PlatesAndBar.common();
    return FutureBuilder<PlatesAndBar>(
      // This is where Future is trying to get data from
      future: SaveStateHelper.getPlatesAndBar(),
      initialData: commonSetup, // default values
      builder: (BuildContext context, AsyncSnapshot<PlatesAndBar> snapshot) {
        if (snapshot.hasError) {
          // Failed to load so fall back to 45 pounds as the bar weight
          return buildPlatesWidget(weight, commonSetup, ctxt);
        } else {
          return buildPlatesWidget(weight, snapshot.data, ctxt);
        }
      }, // End of  builder
    ); // End of FutureBuilder
  }

  Widget buildPlatesWidget(
      double weight, PlatesAndBar barbell, BuildContext ctxt) {
    Map<double, int> platesMap = Calc.getPlateCalculatorMap(weight, barbell);

    bool noPlatesRequired = true;

    for (var plateCount in platesMap.values) {
      // Go through all the plates, if all the counts are zero then no plates
      // required at all
      if (plateCount != 0) {
        noPlatesRequired = false;
      }
    }

    if (noPlatesRequired) {
      return Row(
        children: [
          Container(
            decoration: new BoxDecoration(
              border: new Border.all(
                color: Theme.of(ctxt).dividerColor,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(right: 2.5, left: 2.5, top: 4, bottom: 4),
              child: Text(
                "No plates required!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Make a list of plate widgets by iterating through the map, then put the
    // list as the child on a Row widget,...full send
    List<Widget> platesWidgetlist = new List<Widget>();
    for (MapEntry e in platesMap.entries) {
      String _plateWeightString;
      double _plateWeight = e.key;
      // If the decimal point is truncateble(ie 0) then print 0 decimal places
      // otherwise print 1 decimal place(eg 2.5)
      _plateWeightString = _plateWeight.toStringAsFixed(
          _plateWeight.truncateToDouble() == _plateWeight ? 0 : 1);
      int _platesCount = e.value;

      if (_platesCount != 0) {
        Widget platesWidget = Padding(
          padding: EdgeInsets.only(right: 2.5, left: 2.5),
          child: Container(
            decoration: new BoxDecoration(
              border: new Border.all(
                color: Theme.of(ctxt).dividerColor,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Row(
              children: [
                SizedBox(width: 2.5), // Padding on each side to look better
                Text(
                  "$_plateWeightString x $_platesCount",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 2.5), // Padding on each side to look better
              ],
            ),
          ),
        );
        platesWidgetlist.add(platesWidget);
      }
    }
    return new Row(children: platesWidgetlist);
  }

  @override
  Widget build(BuildContext ctxt) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(children: [
              Text(
                subTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Expanded(child: SizedBox()),
              Text(
                argTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ]),
            SizedBox(
              // This is a custom divider
              height: 10.0,
              child: new Center(
                child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 2.0,
                  color: Colors.red[300],
                ),
              ),
            ),
            SizedBox(height: 20),
            getPlatesWidget(setWeight, ctxt),
          ],
        ),
      ),
    );
  }
}
