import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpandedWidget extends GetWidget {
  final String title;
  final Widget body;
  ExpandedWidget({this.title, this.body});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
        ),
        child: ExpandablePanel(
          theme: ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center),
          header: Text(
            title,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
          ),
          expanded: body,
        ),
      ),
    );
  }
}
