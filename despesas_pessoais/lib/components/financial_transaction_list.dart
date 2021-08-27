import 'package:flutter/material.dart';
import '../models/financial_transaction.dart';
import 'package:intl/intl.dart';

class FinancialTransactionList extends StatelessWidget {
  final List<FinancialTransaction> transactions;
  final void Function(int) onDelete;

  FinancialTransactionList(this.transactions, this.onDelete);

  bool get hasTransactions {
    if (transactions.length == 0) return false;
    return true;
  }

  _confirmRemovalOfTransaction(BuildContext context, int id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Remover Transação?', style: TextStyle(fontSize: 23)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          );
        }).then((value) {
      if (value == 'OK') {
        onDelete(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      child: hasTransactions
          ? ListView(
              children: transactions.map((transaction) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child:
                            FittedBox(child: Text('R\$${transaction.value}')),
                      ),
                    ),
                    title: Text(
                      transaction.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(transaction.date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          _confirmRemovalOfTransaction(context, transaction.id!),
                    ),
                  ),
                );
              }).toList(),
            )
          : Center(
              child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Nenhuma Transação Cadastrada!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                RotationTransition(
                  turns: AlwaysStoppedAnimation(350 / 360),
                  child: Text(
                    'Z',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 70,
                    ),
                  ),
                ),
                RotationTransition(
                  turns: AlwaysStoppedAnimation(200 / 360),
                  child: Text(
                    'Z',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 70,
                    ),
                  ),
                ),
                RotationTransition(
                  turns: AlwaysStoppedAnimation(340 / 360),
                  child: Text(
                    'Z',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 70,
                    ),
                  ),
                ),
              ],
            )
          ),
    );
  }
}
