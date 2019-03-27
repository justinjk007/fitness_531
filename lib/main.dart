import 'package:flutter/material.dart';
import 'save_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: new FirstScreen(),
    );
  }
}

class Weeks extends StatefulWidget {
  Weeks({
    Key key,
    this.argTitle,
    this.subTitle,
    this.weekNum,
  }) : super(key: key);

  final Widget argTitle;
  final Widget subTitle;
  final int weekNum;
  @override
  _WeekWidgetState createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<Weeks> {
  void notifyReceiver() {
    setState(() {
      // Empty method just to refresh widget, collecting new data is handled
      // by FutureBuilder
    });
  }

  Widget _getNextScreen() {
    // Widget nextScreen = new SecondScreen();
    // if (widget.weekNum == 1) {
    //   nextScreen = new ThirdScreen(notifyParent: notifyReceiver);
    // }
    Widget nextScreen = new ThirdScreen(notifyParent: notifyReceiver);
    return nextScreen;
  }

  @override
  Widget build(BuildContext ctxt) {
    return (new Container(
      // foregroundDecoration: BoxDecoration(
      //   color: Colors.grey,
      //   backgroundBlendMode: BlendMode.saturation,
      // ),
      margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: new SizedBox(
        width: double.infinity,
        height: 144.0,
        child: InkWell(
          onTap: () {
            Navigator.push(
              ctxt,
              new MaterialPageRoute(builder: (ctxt) => _getNextScreen()),
            );
          },
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: widget.argTitle,
                  subtitle: widget.subTitle,
                  leading: FutureBuilder<bool>(
                      future: SaveStateHelper.getWeek3(),
                      initialData: true,
                      builder: (BuildContext context,
                          AsyncSnapshot<bool> snapshot) {
                        if (snapshot.hasError) {
                          return Icon(Icons.check_box_outline_blank, color: Colors.red, size: 50.0);
                        } else {
                          if (snapshot.data == true) {
                            // Still active
                            return Icon(Icons.check_box_outline_blank, color: Colors.red, size: 50.0);
                          } else {
                            // Inactive
                            return Icon(Icons.check_box, color: Colors.red, size: 50.0);
                          }
                        }
                      } // End of  builder
                      ), // End of FutureBuilder
                )
              ], // End of list
            ),
          ),
        ),
      ),
    ));
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Select week in your routine")),
      body: new Column(
        children: <Widget>[
          new Weeks(
            argTitle: new Text("Week 1"),
            subTitle: new Text("3 sets of 5 reps\n\n65% x 5     75% x 5     85% x 5 \n\nMaximum weight will be 220 lbs" ),
          ),
          new Weeks(
            argTitle: new Text("Week 1"),
            subTitle: new Text("3 sets of 5 reps\n\n65% x 5     75% x 5     85% x 5 \n\nMaximum weight will be 220 lbs" ),
          ),
          new Weeks(
            argTitle: new Text("Week 1"),
            subTitle: new Text("3 sets of 5 reps\n\n65% x 5     75% x 5     85% x 5 \n\nMaximum weight will be 220 lbs" ),
          ),
          new Weeks(
            argTitle: new Text("Week 1"),
            subTitle: new Text("3 sets of 5 reps\n\n65% x 5     75% x 5     85% x 5 \n\nMaximum weight will be 220 lbs" ),
          ),
        ], // List of cards end here
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  final Function() notifyParent;
  ThirdScreen({Key key, @required this.notifyParent}) : super(key: key);

  void saveData() async {
    await SaveStateHelper.setWeek3(false);
    notifyParent();
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Multi Page Application Page 3"),
      ),
      body: new RaisedButton(
        padding: const EdgeInsets.all(8.0),
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {
          saveData();
        },
        child: new Text("Click to notify parent!"),
      ),
    );
  }
}
