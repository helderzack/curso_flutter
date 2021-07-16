import 'package:percent_indicator/percent_indicator.dart';

import './open-register-modal.dart';
import './transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DespesasPessoaisApp());
}

class _DespesasPessoaisState extends State<DespesasPessoaisApp> {
  List<Transaction> _transactions = [];
  var counter = 1;

  void _createTransaction() {
    setState(() {
      _transactions.add(Transaction("Transação $counter", DateTime.now()));
      counter++;
    });
  }

  bool get hasTransactions {
    if (_transactions.length == 0) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Despesas Pessoais"),
      ),
      body: Column(
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: LinearPercentIndicator(
              width: 100.0,
              percent: 0.0,
              progressColor: Colors.purple,
            ),
          ),
          hasTransactions
              ? ListView.builder(
                  itemCount: _transactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _transactions[index];
                  })
              : Center(
                  child: Text(
                  "Nenhuma Transação Cadastrada!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                )),
        ],
      ),
      floatingActionButton: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.bottomCenter,
        child: OpenRegisterModal(),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}

class DespesasPessoaisApp extends StatefulWidget {
  @override
  _DespesasPessoaisState createState() {
    return _DespesasPessoaisState();
  }
}
