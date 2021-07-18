import './open-register-modal.dart';
import './transaction.dart';
import 'weekly-expenditure-container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DespesasPessoaisApp());
}

class _DespesasPessoaisState extends State<DespesasPessoaisApp> {
  List<Transaction> _transactions = [];
  var counter = 1;

  void _createTransaction(String title, String value, DateTime selectedDate) {
    setState(() {
      _transactions.add(Transaction(title, value, selectedDate));
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
          WeeklyExpenditureContainer(),
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
      // floatingActionButton: StatefulBuilder(
      //   builder: (context, setState) {
      //     return Container(
      //       width: double.infinity,
      //       height: double.infinity,
      //       alignment: Alignment.bottomCenter,
      //       child: OpenRegisterModal(),
      //     );
      //   }
      // ),

      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          backgroundColor: Colors.yellow[600],
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child: OpenRegisterModal(),
                  );
                });
          })
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
