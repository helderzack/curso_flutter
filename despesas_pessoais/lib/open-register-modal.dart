import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class _OpenRegisterModalState extends State<OpenRegisterModal> {
  DateTime _selectedDate;

  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  final _dateFormatter = DateFormat('yMMMMd');

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

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
              controller: _valueController,
              decoration:
              InputDecoration(hintText: 'Valor (R\$)'),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Data Selecionada: ${_checkSelectedDateField() ? '' : _dateFormatter.format(_selectedDate)}'
                ),
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
                    ).then((date) => _setSelectedDate(date));
                  },
                  child: Text(
                    'Selecionar Data',
                  )
                )
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
                    primary: Colors.purple
                  ),
                  onPressed: widget.createTransaction(
                    _titleController.text,
                    _valueController.text,
                    _selectedDate
                  ),
                  child: Text('Nova Transação'))
              ],
            )
          ),
        ],
      )
    );
  }
}

class OpenRegisterModal extends StatefulWidget {
  final Function createTransaction;

  OpenRegisterModal({this.createTransaction});

  @override
  _OpenRegisterModalState createState() {
    return _OpenRegisterModalState();
  }
}
