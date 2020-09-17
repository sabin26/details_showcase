import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String buttonTitle;
  final void Function() onPressed;
  Button({this.buttonTitle, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0, left: 5.0, top: 10.0),
        child: OutlineButton(
          highlightColor: Colors.grey[300],
          splashColor: Colors.grey[200],
          onPressed: onPressed,
          child: Text(
            buttonTitle,
            style: TextStyle(color: Colors.lightBlue, fontSize: 15.0),
          ),
        ),
      ),
    );
  }
}
