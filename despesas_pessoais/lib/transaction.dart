import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  final String transaction;
  final DateTime registerDate;

  Transaction(
    this.transaction, 
    this.registerDate
  );

  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 8,
        shadowColor: Colors.black,
        child: Column(
          children: [
            Row(
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.purple[700],
                  onPressed: null,
                  child: Text(
                    "RS80.0",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  transaction, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            
            Text(
              registerDate.toString(),
              style: TextStyle(
                color: Colors.grey
              ),
            ),
          ],
        ),
      ),
    );
  }
}
