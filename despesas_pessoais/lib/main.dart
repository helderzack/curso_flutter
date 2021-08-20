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
  // This variable '_transations' is not being used for anything really.
  // All the methods that refer to '_transactions' are not being called
  // The only reason I didn't erase this variable is to not break the referencees to it
  final List<Transaction> _transactions = [];
  final TransactionService _transactionService = new TransactionService();

  void _addTransaction(String title, double value, DateTime selectedDate) {
    final newTransaction =
        Transaction(id: 0, title: title, value: value, date: selectedDate);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _removeTransaction(int id) {
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Chart(_transactionService.fetchedTransanctions),
                TransactionList(_transactionService.fetchedTransanctions, _removeTransaction),
              ],
            );
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
