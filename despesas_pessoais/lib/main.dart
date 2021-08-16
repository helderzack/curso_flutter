import 'dart:math';

import 'package:despesas_pessoais/components/chart.dart';

import 'models/transaction.dart';
import 'package:flutter/material.dart';
import '../components/transaction_form.dart';
import '../components/transaction_list.dart';

void main() {
  runApp(DespesasPessoaisApp());
}

class DespesasPessoaisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  void _addTransaction(String title, double value, DateTime selectedDate) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: selectedDate);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _openTransactionForm() {
    showModalBottomSheet(
      context: context,
      builder: (context) => TransactionForm(_addTransaction),
    );
  }

  bool get hasTransactions {
    if (_transactions.length == 0) return false;
    return true;
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Despesas Pessoais"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            hasTransactions
                ? TransactionList(_transactions, _removeTransaction)
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
                  )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: () => _openTransactionForm(),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
