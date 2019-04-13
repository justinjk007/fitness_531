import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'save_state.dart';

class _RecordsPageState extends State<RecordsPage> {
  int _squatRM = 0;
  int _benchRM = 0;
  int _deadliftRM = 0;
  int _pressRM = 0;

  @override
  void initState() {
    super.initState();
    _loadData(); // Load all the Max rep values from memory async
  }

  void _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // If no data exist return 0
      _squatRM = (prefs.getInt("squat") ?? 0);
      _benchRM = (prefs.getInt("bench") ?? 0);
      _deadliftRM = (prefs.getInt("deadlift") ?? 0);
      _pressRM = (prefs.getInt("press") ?? 0);
    });
  }

  IncrementandRefreshParent() {
    _squatRM += 10;
    _benchRM += 5;
    _deadliftRM += 10;
    _pressRM += 5;
    SaveStateHelper.setMaxRepToMemory('squat', _squatRM);
    SaveStateHelper.setMaxRepToMemory('bench', _benchRM);
    SaveStateHelper.setMaxRepToMemory('deadlift', _deadliftRM);
    SaveStateHelper.setMaxRepToMemory('press', _pressRM);
    // Refersh widget
    setState(() {});
  }

  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      // drawer: new SideDrawer(),
      appBar: new AppBar(title: new Text("Set 1 rep max records")),
      body: Padding(
        padding: EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Center(
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter 1RM for squat (Current: ${_squatRM} lbs)'),
                onSubmitted: (value) {
                  SaveStateHelper.setMaxRepToMemory('squat', int.parse(value));
                },
              ),
              SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter 1RM for bench (Current: ${_benchRM} lbs)'),
                onSubmitted: (value) {
                  SaveStateHelper.setMaxRepToMemory('bench', int.parse(value));
                },
              ),
              SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText:
                        'Enter 1RM for deadlift (Current: ${_deadliftRM} lbs)'),
                onSubmitted: (value) {
                  SaveStateHelper.setMaxRepToMemory(
                      'deadlift', int.parse(value));
                },
              ),
              SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter 1RM for press (Current: ${_pressRM} lbs)'),
                onSubmitted: (value) {
                  SaveStateHelper.setMaxRepToMemory('press', int.parse(value));
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          IncrementandRefreshParent();
        },
        icon: Icon(Icons.add),
        label: Text("Increment"),
        tooltip: "Auto increment all values",
        backgroundColor: Colors.red[400],
      ),
    );
  }
}

class RecordsPage extends StatefulWidget {
  RecordsPage({
    Key key,
  }) : super(key: key);

  @override
  _RecordsPageState createState() => _RecordsPageState();
}
