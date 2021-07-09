import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Resultado extends StatelessWidget {
  final int pontuacaoTotal;
  final void Function() resetQuestionario;

  Resultado(this.pontuacaoTotal, this.resetQuestionario);

  String get fraseResultado {
    if (pontuacaoTotal < 8) {
      return 'Parabéns!';
    } else if (pontuacaoTotal < 12) {
      return 'Você é bom!';
    } else if (pontuacaoTotal < 16) {
      return 'Impressionante!';
    } else {
      return 'Nível Jedi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.all(30),
          child:
          Text(
            'Pontuação: $pontuacaoTotal.', 
            style: TextStyle(fontSize: 28)
          ),
        ),
        Container(
          margin: EdgeInsets.all(30),
          child:
          Text(
            fraseResultado, 
            style: TextStyle(fontSize: 28)
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
          ),
          child: Text("Reiniciar Questionário"),
          onPressed: resetQuestionario,
        ),
      ]
    ));
  }
}
