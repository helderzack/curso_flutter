import 'package:flutter/material.dart';

class OpenRegisterModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: FloatingActionButton(
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
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Título'
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Valor (R\$)'
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.purple
                          ),
                          onPressed: () => print('Placeholder Selecionar Data'), 
                          child: Text(
                            'Selecionar Data'
                          )
                        )
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purple
                          ),
                          onPressed: () => print('Placeholder Nova Transação'), 
                          child: Text(
                            'Nova Transação'
                          )
                        )
                      ),
                    ],
                  )
                );
              });
          }
      ),
    );
  }
}
