import 'package:flutter/material.dart';
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

  Widget getPlatesWidget(double weight) {
    Map<double, int> platesMap = Calc.getPlateCalculatorMap(weight);

    bool noPlatesRequired = true;

    for (var plateCount in platesMap.values) {
      if (plateCount != 0) {
        noPlatesRequired = false;
      }
    }

    if (noPlatesRequired) {
      return Row(
        children: [
          SizedBox(width: 5),
          Text(
            "No plates required!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Visibility(
          visible: !checkEqual(platesMap[45], 0),
          child: Row(
            children: [
              SizedBox(width: 5),
              Text(
                "${platesMap[45]} x ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Image.asset(
                'assets/45.png',
                width: 17,
                height: 17,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 5),
            ],
          ),
        ),
        Visibility(
          visible: !checkEqual(platesMap[35], 0),
          child: Row(
            children: [
              SizedBox(width: 5),
              Text(
                "${platesMap[35]} x ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Image.asset(
                'assets/35.png',
                width: 17,
                height: 17,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 5),
            ],
          ),
        ), // Visibility widget ends her
        Visibility(
          visible: !checkEqual(platesMap[25], 0),
          child: Row(
            children: [
              SizedBox(width: 5),
              Text(
                "${platesMap[25]} x ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Image.asset(
                'assets/25.png',
                width: 17,
                height: 17,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 5),
            ],
          ),
        ), // Visibility widget ends her
        Visibility(
          visible: !checkEqual(platesMap[10], 0),
          child: Row(
            children: [
              SizedBox(width: 5),
              Text(
                "${platesMap[10]} x ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Image.asset(
                'assets/10.png',
                width: 17,
                height: 17,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 5),
            ],
          ),
        ), // Visibility widget ends her
        Visibility(
          visible: !checkEqual(platesMap[5], 0),
          child: Row(
            children: [
              SizedBox(width: 5),
              Text(
                "${platesMap[5]} x ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Image.asset(
                'assets/5.png',
                width: 17,
                height: 17,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 5),
            ],
          ),
        ), // Visibility widget ends her
        Visibility(
          visible: !checkEqual(platesMap[2.5], 0),
          child: Row(
            children: [
              SizedBox(width: 5),
              Text(
                "${platesMap[2.5]} x ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              Image.asset(
                'assets/2.5.png',
                width: 17,
                height: 17,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 5),
            ],
          ),
        ), // Visibility widget ends her
      ],
    );
  }

  @override
  Widget build(BuildContext ctxt) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.red[100],
              blurRadius: 15.0,
            ),
          ],
        ),
        child: Material(
          borderRadius: new BorderRadius.circular(4.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(children: [
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    argTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ]),
                SizedBox(
                  // This is a custom divider
                  height: 10.0,
                  child: new Center(
                    child: new Container(
                      margin:
                          new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                      height: 2.0,
                      color: Colors.red[100],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                getPlatesWidget(setWeight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
