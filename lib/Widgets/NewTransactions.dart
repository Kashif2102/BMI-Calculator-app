import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Widgets/Adaptive_Button.dart';

class NewTransaction extends StatefulWidget {
  final Function addnewTx;

  NewTransaction(this.addnewTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _heightcontroller = TextEditingController();
  final _weightcontroller = TextEditingController();
  DateTime? _selectedDate;

  @override
  void SubmitData() {
    final enteredheight = double.parse(_heightcontroller.text);
    final enteredweight = double.parse(_weightcontroller.text);

    if (enteredheight <= 0 || enteredweight <= 0 || _selectedDate == null) {
      return;
    }
    ;

    widget.addnewTx(enteredheight, enteredweight, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentdatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedate) {
      if (pickedate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedate;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.send), hintText: "height (in cm)"),
                controller: _heightcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => SubmitData(),
              ),
              TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.send), hintText: "weight (in kg)"),
                controller: _weightcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => SubmitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Selected'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate as DateTime)}'),
                    ),
                    Adaptivebutton("Choose Date", _presentdatepicker),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: SubmitData,
                child: Text(
                  "Calculate BMI",
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
