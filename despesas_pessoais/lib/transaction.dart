import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction extends StatelessWidget {
  final String transaction;
  final String value;
  final DateTime registerDate;
  final Function removeTransaction;
  final DateFormat dateFormatter = DateFormat('yMMMMd');

  Transaction(
    this.transaction, 
    this.value, 
    this.registerDate, 
    this.removeTransaction
  );

  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 4,
        shadowColor: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.purple[700],
                  onPressed: null,
                  child: Text(
                    "R\$$value",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          transaction,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        '${dateFormatter.format(registerDate)}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                'Remover Transação?',
                                style: TextStyle(fontSize: 23)
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: Text(
                                    'OK',
                                    style: TextStyle(fontSize: 20),
                                  )
                                )
                              ],
                            );
                          }
                        ).then((value) {
                          if (value == 'OK') this.removeTransaction(this);
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
