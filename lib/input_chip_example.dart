import 'package:flutter/material.dart';

class InputChipExample extends StatefulWidget {
  @override
  InputChipExampleState createState() => new InputChipExampleState();
}

class InputChipExampleState extends State<InputChipExample> {
  TextEditingController _textEditingController = new TextEditingController();

  List<String> _values = new List();
  List<bool> _selected = new List();

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  Widget buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < _values.length; i++) {
      InputChip actionChip = InputChip(
        selected: _selected[i],
        label: Text(_values[i]),
        elevation: 10,
        pressElevation: 5,
        onPressed: () {
          setState(() {
            _selected[i] = !_selected[i];
          });
        },
        onDeleted: () {
          _values.removeAt(i);
          _selected.removeAt(i);
          setState(() {
            _values = _values;
            _selected = _selected;
          });
        },
      );
      chips.add(actionChip);
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
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
              Container(
                height: 30,
                child: buildChips(),
              ),
              TextFormField(
                controller: _textEditingController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    _values.add(_textEditingController.text);
                    _selected.add(true);
                    _textEditingController.clear();
                    setState(() {
                      _values = _values;
                      _selected = _selected;
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
