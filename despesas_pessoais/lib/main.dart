import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/financial_transaction.dart';
import '../components/chart.dart';
import 'components/financial_transaction_form.dart';
import 'components/financial_transaction_list.dart';
import '../db/database_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(DespesasPessoaisApp());
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPageHome(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // accentColor: Colors.amber,
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

class LoginPageHome extends StatefulWidget {
  @override
  _LoginPageHomeState createState() => _LoginPageHomeState();
}

class _LoginPageHomeState extends State<LoginPageHome> {
  void login() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(labelText: 'Username'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(labelText: 'Password'),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  login();
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DespesasPessoaisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        // primarySwatch: Colors.purple,
        // accentColor: Colors.amber,
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

  void _logout() {
    Navigator.pop(context);
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

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(
            child: Icon(icon),
            onTap: fn,
          )
        : IconButton(
            onPressed: fn,
            icon: Icon(icon),
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.square_list : Icons.list;
    final chartList =
        Platform.isIOS ? CupertinoIcons.chart_bar : Icons.stacked_bar_chart;
    final logoutList =
        Platform.isIOS ? CupertinoIcons.arrow_left : Icons.logout;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          _showChart ? iconList : chartList,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionForm(),
      ),
      _getIconButton(logoutList, 
      () => _logout(),
      ),
    ];

    final appBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.purple,
      title: Text("Despesas Pessoais"),
      actions: actions,
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
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
                      height: availableHeight * (isLandscape ? 0.8 : 0.3),
                      child: Chart(_getRecentTransactions(snapshot.data!))),
                if (!_showChart || !isLandscape)
                  Container(
                      height: availableHeight * (isLandscape ? 1 : 0.7),
                      child: FinancialTransactionList(
                          snapshot.data!, _removeTransaction)),
              ],
            );
          },
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    onPressed: () => _openTransactionForm(),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
