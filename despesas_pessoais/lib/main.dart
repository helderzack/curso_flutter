import 'package:despesas_pessoais/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import '../components/chart.dart';
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
  late List<Transaction> _transactions;
  final TransactionService _transactionService = new TransactionService();

  void _addTransaction(String title, double value, DateTime selectedDate) {
    final newTransaction =
        Transaction(id: 0, title: title, value: value, date: selectedDate);

    _transactionService.postTransaction(newTransaction).whenComplete(() {
      setState(() {});
    });
    Navigator.of(context).pop();
  }

  void _removeTransaction(int id) {
    _transactionService.deleteTransaction(id).whenComplete(() {
      setState(() {});
    });
  }

  void _openTransactionForm() {
    showModalBottomSheet(
      context: context,
      builder: (context) => TransactionForm(_addTransaction),
    );
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
        child: FutureBuilder<List<Transaction>>(
          future: _transactionService.getTransactions(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              _transactions = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Chart(_recentTransactions),
                  TransactionList(_transactions, _removeTransaction),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionForm(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
