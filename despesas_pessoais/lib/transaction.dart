import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  final String transaction;
  final DateTime registerDate;

  Transaction(
    this.transaction, 
    this.registerDate,
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
                    "R\$80.0",
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
                        registerDate.toString(),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,

                  child: IconButton(
                    onPressed: () => print(this.key.hashCode),
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    )
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
