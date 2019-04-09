import 'package:flutter/material.dart';
import 'save_state.dart';

class RecordsPage extends StatelessWidget {
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
              FutureBuilder<int>(
                // This is where Future is trying to get data from
                future: SaveStateHelper.getMaxRepFromMemory('squat'),
                initialData: 0,
                builder: (BuildContext ctxt, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasError) {
                    return TextField(); // Show empty textfield
                  } else {
                    return TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText:
                              'Enter 1RM for squat (Current: ${snapshot.data} lbs)'),
                      onSubmitted: (value) {
                        SaveStateHelper.setMaxRepToMemory(
                            'squat', int.parse(value));
                      },
                    );
                  }
                }, // End of  builder
              ), // End of FutureBuilder
              SizedBox(height: 30),
              FutureBuilder<int>(
                // This is where Future is trying to get data from
                future: SaveStateHelper.getMaxRepFromMemory('bench'),
                initialData: 0,
                builder: (BuildContext ctxt, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasError) {
                    return TextField(); // Show empty textfield
                  } else {
                    return TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText:
                              'Enter 1RM for bench (Current: ${snapshot.data} lbs)'),
                      onSubmitted: (value) {
                        SaveStateHelper.setMaxRepToMemory(
                            'bench', int.parse(value));
                      },
                    );
                  }
                }, // End of  builder
              ), // End of FutureBuilder
              SizedBox(height: 30),
              FutureBuilder<int>(
                // This is where Future is trying to get data from
                future: SaveStateHelper.getMaxRepFromMemory('deadlift'),
                initialData: 0,
                builder: (BuildContext ctxt, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasError) {
                    return TextField(); // Show empty textfield
                  } else {
                    return TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText:
                              'Enter 1RM for deadlift (Current: ${snapshot.data} lbs)'),
                      onSubmitted: (value) {
                        SaveStateHelper.setMaxRepToMemory(
                            'deadlift', int.parse(value));
                      },
                    );
                  }
                }, // End of  builder
              ), // End of FutureBuilder
              SizedBox(height: 30),
              FutureBuilder<int>(
                // This is where Future is trying to get data from
                future: SaveStateHelper.getMaxRepFromMemory('press'),
                initialData: 0,
                builder: (BuildContext ctxt, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasError) {
                    return TextField(); // Show empty textfield
                  } else {
                    return TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText:
                              'Enter 1RM for press (Current: ${snapshot.data} lbs)'),
                      onSubmitted: (value) {
                        SaveStateHelper.setMaxRepToMemory(
                            'press', int.parse(value));
                      },
                    );
                  }
                }, // End of  builder
              ), // End of FutureBuilder
            ],
          ),
        ),
      ),
    );
  }
}
