import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

import './Widgets/transactions_list.dart';
import './Widgets/NewTransactions.dart';
import './Models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //This tells the app to only run in portrait mode
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BMI Calculator",
      theme: ThemeData(
          primarySwatch: Colors.brown,
          accentColor: Colors.greenAccent,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
    double txheight,
    double txweight,
    DateTime chosenDate,
  ) {
    final newTx = Transaction(
        BMI: double.parse(
            ((txweight / (txheight * txheight)) * 10000).toStringAsFixed(2)),
        height: txheight,
        weight: txweight,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    //We have created this variable so we don't recreate the MediaQuery Object again and again
    //This is a recommended practice for whenever an object is used several times throughout the build method
    final mediaquery = MediaQuery.of(context);

    final isLandscape = mediaquery.orientation == Orientation.landscape;
    //the created variable isLandscape will be a boolean which is true for when the orientation is landscape

    final appbar = AppBar(
      //We turned appbar into a variable so we could use "appbar.preferredsSize.height" in the dynamic spacing of containers.
      title: Text("BMI Calculator"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    //Made this to avoid duplication of code
    final txListWidget = Container(
        height: (mediaquery.size.height -
                appbar.preferredSize.height -
                mediaquery.padding.top) *
            1,
        child: TransactionsList(_userTransactions, deleteTransaction));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            txListWidget,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//We can use ternary operators with Platform.isIOS or Platform.isAndroid
//we need to import 'dart:io';
