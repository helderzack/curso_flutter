import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './transaction.dart';
import 'weekly-expenditure-container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(DespesasPessoaisApp());
}

GlobalKey<WeeklyExpenditureContainerState> weeklyExpenditureKey = GlobalKey();

class _DespesasPessoaisState extends State<DespesasPessoaisApp> {
  List<Transaction> _transactions = [];
  DateTime _selectedDate;

  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  final _dateFormatter = DateFormat('dd/MM/yyyy');

  void _removeTransaction(Transaction transaction) {
    String value = transaction.value;
    DateTime registerDate = transaction.registerDate;

    setState(() {
      _transactions.remove(transaction);
    });

    weeklyExpenditureKey.currentState.removeExpenditure(registerDate, double.parse(value));
  }

  void _createTransaction(String title, String value, DateTime selectedDate) {
    print(title);
    print(value);
    print(selectedDate.toString());
    setState(() {
      _transactions
          .add(Transaction(title, value, _selectedDate, _removeTransaction));
    });

    weeklyExpenditureKey.currentState
        .updateWeeklyExpenditureState(selectedDate, double.parse(value));
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [Locale('pt', 'BR')],
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("Despesas Pessoais"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              WeeklyExpenditureContainer(key: weeklyExpenditureKey),
              hasTransactions
              ? SizedBox(
                  height: 300.0,
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemCount: _transactions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _transactions[index];
                        }),
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
            ],
          ),
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
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty)
                                          return '';
                                        return null;
                                      },
                                      controller: _titleController,
                                      decoration:
                                          InputDecoration(hintText: 'Título'),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty)
                                          return '';
                                        return null;
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      controller: _valueController,
                                      decoration: InputDecoration(
                                          hintText: 'Valor (R\$)'),
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
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.now()
                                                    .add(Duration(days: 6)),
                                              ).then((date) =>
                                                  _setSelectedDate(date));
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
                                                if (_formKey.currentState
                                                        .validate() ==
                                                    false) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'Preencha todos os campos!')));
                                                } else {
                                                  Navigator.pop(context);
                                                  _createTransaction(
                                                      _titleController.text,
                                                      _valueController.text,
                                                      _selectedDate);
                                                }
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
      )
    );
  }
}

class DespesasPessoaisApp extends StatefulWidget {
  @override
  _DespesasPessoaisState createState() {
    return _DespesasPessoaisState();
  }
}
