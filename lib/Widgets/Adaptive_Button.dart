import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Adaptivebutton extends StatelessWidget {
  final String text;
  final VoidCallback datepicker;

  Adaptivebutton(this.text, this.datepicker);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: datepicker,
          )
        : FlatButton(
            child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: datepicker,
            textColor: Theme.of(context).primaryColor,
          );
  }
}
