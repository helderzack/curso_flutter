import 'package:flutter/services.dart';

import './transaction.dart';
import 'weekly-expenditure-container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(DespesasPessoaisApp());
}

class _DespesasPessoaisState extends State<DespesasPessoaisApp> {
  List<Transaction> _transactions = [];
  DateTime _selectedDate;

  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  final _dateFormatter = DateFormat('yMMMMd');

  void _createTransaction(String title, String value, DateTime selectedDate) {
    print(title);
    print(value);
    print(selectedDate.toString());
    setState(() {
      _transactions.add(Transaction(title, value, _selectedDate));
    });
  }

  void _setSelectedDate(DateTime selectedDate) {
    setState(() {
      this._selectedDate = selectedDate;
    });
    print(_selectedDate);
  }

  bool _checkSelectedDateField() {
    if (_selectedDate == null) return true;
    return false;
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
              ? Expanded(
                  child: ListView.builder(
                    itemCount: _transactions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _transactions[index];
                    }
                  ),
                )
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
                        child: Form(
                            child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: TextField(
                                controller: _titleController,
                                decoration: InputDecoration(hintText: 'Título'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: TextField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: _valueController,
                                decoration:
                                    InputDecoration(hintText: 'Valor (R\$)'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Data Selecionada: ${_checkSelectedDateField() ? '' : _dateFormatter.format(_selectedDate)}'),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.purple,
                                      ),
                                      onPressed: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2001),
                                          lastDate: DateTime(2050),
                                        ).then(
                                            (date) => _setSelectedDate(date));
                                      },
                                      child: Text(
                                        'Selecionar Data',
                                      ))
                                ],
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.purple),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _createTransaction(
                                              _titleController.text,
                                              _valueController.text,
                                              _selectedDate);
                                        },
                                        child: Text('Nova Transação'))
                                  ],
                                )),
                          ],
                        )),
                      );
                    });
              })),

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
