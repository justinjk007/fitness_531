import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class InputChipExampleState extends State<InputChipExample> {
  TextEditingController _textEditingController = new TextEditingController();

  // Here these maps are kept dynamic so serialized json does not error out when
  // read back in, however we only accept bool as keys in design
  Map<String,dynamic> defaultMap = {
    '2.5': true,
    '5': true,
    '10': true,
    '25': true,
    '35': false,
    '45': true,
  };
  Map<String,dynamic> chipsMap = {'0': true};

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadDataAsync(); // Load the current bar weight from memory
  }

  void _loadDataAsync() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String foo = (prefs.getString("plates_available") ?? null);
      if (foo == null || foo == "{}") {
        // If no data exist return default map
        chipsMap = defaultMap;
      } else {
        chipsMap = json.decode(foo);
      }
    });
  }

  void saveDataToDisk() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String foo = json.encode(chipsMap);
    prefs.setString("plates_available", foo);
  }

  Widget _buildChips() {
    List<Widget> chips = new List();

    for (MapEntry e in chipsMap.entries) {
      InputChip actionChip = InputChip(
        label: Text(e.key),
        selected: e.value,
        // elevation: 10,
        pressElevation: 5,
        onPressed: () {
          setState(() {
            // When pressed, toggle selection state and then reload
            chipsMap[e.key] = !e.value;
            saveDataToDisk();
          });
        },
        onDeleted: () {
          chipsMap.remove(e.key);
          setState(() {
            chipsMap = chipsMap;
            saveDataToDisk();
          });
        },
      );
      chips.add(actionChip);
    }

    return Wrap(
      spacing: 2, // gap between adjacent chips
      runSpacing: 1, // gap between lines
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set plates available'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              _buildChips(),
              TextFormField(
                controller: _textEditingController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    chipsMap[_textEditingController.text] = true;
                    _textEditingController.clear();
                    setState(() {
                      chipsMap = chipsMap;
                      saveDataToDisk();
                    });
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          )),
    );
  }
}

class InputChipExample extends StatefulWidget {
  @override
  InputChipExampleState createState() => new InputChipExampleState();
}
