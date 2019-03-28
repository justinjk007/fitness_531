import 'package:flutter/material.dart';
import 'save_state.dart';

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
