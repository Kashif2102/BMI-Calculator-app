import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;

  TransactionsList(this.transactions, this.deletetx);

  String statement(double BMI) {
    if (BMI <= 18.5) {
      return "Low";
    } else if (BMI > 18.5 && BMI <= 24.9) {
      return "Optimal";
    } else if (BMI > 24.9 && BMI < 29.9) {
      return "High";
    } else {
      return "Very High";
    }
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: ((context, constraints) {
            //We use LayoutBuilder so we can use commands like constraints.maxHeight etc
            return Column(
              children: <Widget>[
                Text('No data added yet!',
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * 0.7,
                  child: Image.asset(
                    'images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          }))
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  tileColor: Colors.amber,
                  leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text('${transactions[index].BMI}'),
                          ))),
                  title: Text(
                    statement(transactions[index].BMI),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    (DateFormat.yMMMd().format(transactions[index].date)),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          onPressed: () => deletetx(transactions[index].id),
                          icon: const Icon(Icons.delete),
                          label: Text("Delete"),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          onPressed: () => deletetx(transactions[index].id),
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}






//alternate way to implement a list 
//the below value is returned to ListView.builder() along with
//itembuilder(context,index) {}

// return Card(
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                           margin: EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 15),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Theme.of(context).primaryColor,
//                               width: 2,
//                             ),
//                           ),
//                           padding: EdgeInsets.all(10),
//                           child: Text(
//                             '\$${transactions[index].amount.toStringAsFixed(2)}',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                                 color: Theme.of(context).primaryColor),
//                           )),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(transactions[index].title,
//                               style: TextStyle(
//                                   fontSize: 15, fontWeight: FontWeight.bold)),
//                           Text(
//                             DateFormat.yMMMd().format(transactions[index].date),
//                             style: TextStyle(fontSize: 12, color: Colors.grey),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 );