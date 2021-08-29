import 'package:flutter/material.dart';
import 'models/financial_transaction.dart';
import '../components/chart.dart';
import 'components/financial_transaction_form.dart';
import 'components/financial_transaction_list.dart';
import '../db/database_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  void _addTransaction(String title, double value, DateTime selectedDate) {
    final newTransaction =
        FinancialTransaction(title: title, value: value, date: selectedDate);

    DatabaseHelper.instance.addFinancialTransaction(newTransaction);
    Navigator.of(context).pop();
    setState(() {});
  }

  void _removeTransaction(int id) {
    setState(() {
      DatabaseHelper.instance.removeFinancialTransaction(id);
    });
  }

  void _openTransactionForm() {
    showModalBottomSheet(
      context: context,
      builder: (context) => FinancialTransactionForm(_addTransaction),
    );
  }

  List<FinancialTransaction> _getRecentTransactions(
      List<FinancialTransaction> transactions) {
    return transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      backgroundColor: Colors.purple,
      title: Text("Despesas Pessoais"),
      actions: [
        if (isLandscape)
          IconButton(
            icon: Icon(_showChart ? Icons.list : Icons.stacked_bar_chart),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: FutureBuilder<List<FinancialTransaction>>(
          future: DatabaseHelper.instance.getFinancialTransaction(),
          builder: (BuildContext context,
              AsyncSnapshot<List<FinancialTransaction>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_showChart || !isLandscape)
                  Container(
                      height: availableHeight * (isLandscape ? 0.7 : 0.3),
                      child: Chart(_getRecentTransactions(snapshot.data!))),
                if (!_showChart || !isLandscape)
                  Container(
                      height: availableHeight * 0.7,
                      child: FinancialTransactionList(
                          snapshot.data!, _removeTransaction)),
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
