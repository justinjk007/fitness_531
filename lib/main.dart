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
    this.weekID,
  }) : super(key: key);

  final Widget argTitle;
  final Widget subTitle;
  final String weekID;
  @override
  _WeekWidgetState createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<Weeks> {
  void notifyReceiver() {
    setState(() {
      // Empty method just to refresh widget, collecting new data is handled by
      // FutureBuilder. It gets data from memory and loads a default if it
      // doens't find any
    });
  }

  Widget _getNextScreen() {
    Widget nextScreen = new ThirdScreen(
        notifyParent: notifyReceiver, weekIDForChild: widget.weekID);
    return nextScreen;
  }

  @override
  Widget build(BuildContext ctxt) {
    return (new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: Card(
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: widget.argTitle,
                  subtitle: widget.subTitle,
                  leading: FutureBuilder<bool>(
                      future: SaveStateHelper.getWeek(widget.weekID),
                      initialData: true,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (snapshot.hasError) {
                          return Icon(Icons.check_box_outline_blank,
                              color: Colors.red, size: 50.0);
                        } else {
                          if (snapshot.data == true) {
                            // Still active
                            return Icon(Icons.check_box_outline_blank,
                                color: Colors.red, size: 50.0);
                          } else {
                            // Inactive
                            return Icon(Icons.check_box,
                                color: Colors.red, size: 50.0);
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
            weekID: 'week1',
            argTitle: new Text("Week 1"),
            subTitle:
                new Text("3 sets of 5 reps\n\n65% x 5     75% x 5     85% x 5"),
          ),
          new Weeks(
            weekID: 'week2',
            argTitle: new Text("Week 2"),
            subTitle:
                new Text("3 sets of 3 reps\n\n70% x 3     80% x 3     90% x 3"),
          ),
          new Weeks(
            weekID: 'week3',
            argTitle: new Text("Week 3"),
            subTitle: new Text(
                "3 sets of 5/3/1 reps\n\n75% x 5     85% x 3     95% x 1"),
          ),
          new Weeks(
            weekID: 'week4',
            argTitle: new Text("Week 4"),
            subTitle:
                new Text("Deload week\n\n40% x 5     50% x 5     60% x 5"),
          ),
        ], // List of cards end here
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  final Function() notifyParent;
  final String weekIDForChild;
  ThirdScreen({
    Key key,
    @required this.notifyParent,
    @required this.weekIDForChild,
  }) : super(key: key);

  void saveData() async {
    await SaveStateHelper.toggleWeek(weekIDForChild);
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
