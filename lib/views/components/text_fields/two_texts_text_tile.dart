import 'package:flutter/material.dart';

class TwoTextsTextTile extends StatelessWidget {
  final String title;
  final String subtile;
  final Color textColor;

  const TwoTextsTextTile(
      {Key key,
      @required this.title,
      @required this.subtile,
      this.textColor = Colors.black45})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  subtile,
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
              )
            ],
          ),
          Divider(
            indent: 5,
            endIndent: 5,
          ),
        ],
      ),
    );
  }
}
