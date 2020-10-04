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

  bool checkEqual(int a, int b) {
    return a == b;
  }

  bool isEmpty(int a) {
    return (a == 0 || a == null);
  }

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

    return Row(
      children: [
        Visibility(
          visible: !isEmpty(platesMap[45]), // no plates = invisible
          child: Padding(
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
                    "${platesMap[45]} x 45",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 2.5), // Padding on each side to look better
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: !isEmpty(platesMap[35]), // no plates = invisible
          child: Padding(
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
                    "${platesMap[35]} x 35",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 2.5), // Padding on each side to look better
                ],
              ),
            ),
          ),
        ), // Visibility widget ends her
        Visibility(
          visible: !isEmpty(platesMap[25]), // no plates = invisible
          child: Padding(
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
                    "${platesMap[25]} x 25",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 2.5), // Padding on each side to look better
                ],
              ),
            ),
          ),
        ), // Visibility widget ends her
        Visibility(
          visible: !isEmpty(platesMap[10]), // no plates = invisible
          child: Padding(
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
                    "${platesMap[10]} x 10",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 2.5), // Padding on each side to look better
                ],
              ),
            ),
          ),
        ), // Visibility widget ends her
        Visibility(
          visible: !isEmpty(platesMap[5]), // no plates = invisible
          child: Padding(
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
                    "${platesMap[5]} x 5",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 2.5), // Padding on each side to look better
                ],
              ),
            ),
          ),
        ), // Visibility widget ends her
        Visibility(
          visible: !isEmpty(platesMap[2.5]), // no plates = invisible
          child: Padding(
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
                    "${platesMap[2.5]} x 2.5",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 2.5), // Padding on each side to look better
                ],
              ),
            ),
          ),
        ), // Visibility widget ends her
      ],
    );
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
