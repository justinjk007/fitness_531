import 'package:flutter/material.dart';

//////////////////////////////////////////////////////////////////////////////////////
// This is the widget that displays a picture of an exercise and is clickable which //
// take you to the next page.                                                       //
// This widget also have a done state.                                              //
//////////////////////////////////////////////////////////////////////////////////////

class Activity extends StatefulWidget {
  Activity({
    Key key,
    this.image,
    this.action,
    this.color,
  }) : super(key: key);

  final Color color;
  final String image;
  final Function action;
  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<Activity> {
  @override
  Widget build(BuildContext ctxt) {
    return new Expanded(
      child: SizedBox(
        height: 250,
        child: Material(
          color: widget.color,
          elevation: 4.0,
          child: Stack(
            children: [
              Center(
                child: Icon(Icons.beenhere,
                    color: Colors.red[300].withOpacity(0.5), size: 150.0),
              ),
              Positioned.fill(
                child: Ink.image(
                  image: AssetImage(widget.image),
                  width: 120.0,
                  child: InkWell(
                    onTap: widget.action,
                    splashColor: Colors.red[200],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
