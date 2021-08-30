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
                    trailing: MediaQuery.of(context).size.width > 400
                        ? TextButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('Remove'),
                            style: TextButton.styleFrom(
                              primary: Theme.of(context).errorColor
                            ),
                            onPressed: () => _confirmRemovalOfTransaction(
                                context, transaction.id!),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => _confirmRemovalOfTransaction(
                                context, transaction.id!),
                          ),
                  ),
                );
              }).toList(),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Nenhuma Transação Cadastrada!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
