import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  final String transaction;

  Transaction(this.transaction);

  Widget build(BuildContext context) {
    return Text(transaction);
  }
}
