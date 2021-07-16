import 'package:flutter/material.dart';

class _OpenRegisterModalState extends State<OpenRegisterModal> {
  DateTime? _selectedDate;

  _setSelectedDate(DateTime? selectedDate) {
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
  Widget build(BuildContext context) {
    return Container(
        child: FloatingActionButton(
            backgroundColor: Colors.yellow[600],
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context, builder: (BuildContext context) {
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextField(
                            decoration: InputDecoration(hintText: 'Título'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextField(
                            decoration: InputDecoration(hintText: 'Valor (R\$)'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Data Selecionada: ${_checkSelectedDateField() ? '' : _selectedDate.toString()}'
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
                                style: ElevatedButton.styleFrom(primary: Colors.purple),
                                onPressed: () => print('Placeholder Nova Transação'),
                                child: Text('Nova Transação')
                              )
                            ],
                          )
                        ),
                      ],
                    )
                  );
                }
              );
            }
        )
    );
  }
}

class OpenRegisterModal extends StatefulWidget {
  @override
  _OpenRegisterModalState createState() {
    return _OpenRegisterModalState();
  }
}
