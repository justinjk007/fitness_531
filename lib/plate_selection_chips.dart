import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter/material.dart';
import 'save_state.dart';

class PlateSelectionChipsState extends State<PlateSelectionChips> {
  TextEditingController _textEditingController = new TextEditingController();

  // Here these maps are kept dynamic so serialized json does not error out when
  // read back in, however we only accept bool as keys in design
  Map<String, dynamic> chipsMap = {'0': true};

  @override
  void dispose() {
    _textEditingController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SaveStateHelper.getPlatesMap().then(
      (data) => setState(() {
        chipsMap = data;
      }),
    );
  }

  Widget _buildChips() {
    List<Widget> chips = new List();

    for (MapEntry e in chipsMap.entries) {
      InputChip inputChip = InputChip(
        label: Text("${e.key} lbs"),
        selected: e.value,
        elevation: 2,
        pressElevation: 5,
        showCheckmark: false,
        onPressed: () {
          setState(() {
            // When pressed, toggle selection state and then reload
            chipsMap[e.key] = !e.value;
            SaveStateHelper.setPlatesMap(chipsMap);
          });
        },
        onDeleted: () {
          chipsMap.remove(e.key);
          setState(() {
            chipsMap = chipsMap;
            SaveStateHelper.setPlatesMap(chipsMap);
          });
        },
      );
      chips.add(inputChip);
    }

    return Wrap(
      spacing: 2, // gap between adjacent chips
      runSpacing: -5, // gap between lines
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check if the keyboard is up
    final bool _keyboardNotUp =
        MediaQuery.of(widget.dialogWindowContext).viewInsets.bottom == 0.0;

    return FractionallySizedBox(
      // Use more space if keyword is up so the window is still big
      heightFactor: _keyboardNotUp ? 0.50 : 0.80,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 80,
            child: SingleChildScrollView(
              child: _buildChips(),
            ),
          ),
          Expanded(child: SizedBox()), // Move the button to the right
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(OMIcons.assignment),
                labelText: "Enter plate weight in lbs",
                errorStyle: TextStyle(
                    color: Theme.of(context).errorColor,
                    fontWeight: FontWeight.bold),
              ),
              controller: _textEditingController,
            ),
          ),
          Row(
            children: [
              Expanded(child: SizedBox()), // Move the button to the right
              FlatButton(
                onPressed: () {
                  chipsMap[_textEditingController.text] = true;
                  _textEditingController.clear();
                  setState(() {
                    chipsMap = chipsMap;
                    SaveStateHelper.setPlatesMap(chipsMap);
                  });
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PlateSelectionChips extends StatefulWidget {
  PlateSelectionChips({
    Key key,
    this.dialogWindowContext,
  }) : super(key: key);

  // Build context from the dialog window, used to check if the keyboard is up
  final BuildContext dialogWindowContext;

  @override
  PlateSelectionChipsState createState() => new PlateSelectionChipsState();
}
