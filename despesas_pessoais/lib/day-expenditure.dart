import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DayExpenditureState extends State<DayExpenditure> {
  double amountSpent = 0.0;
  double percentage = 0.0;

  void addExpense(double amountSpent) {
    setState(() {
      this.amountSpent += amountSpent;
    });
    // this.amountSpent += amountSpent;
    print('Amount spent in element: $percentage');
  }

  void adjustPercentage(double percentage) {
    setState(() {
      this.percentage = percentage;
    });
    // this.percentage = percentage;
    print('Percentage: $percentage');
  }

  void subtractExpense(double amountNotSpent) {
    setState(() {
      this.amountSpent -= amountNotSpent;
    });
    // this.amountSpent -= amountNotSpent;
    print('Amount spent in element: $percentage');
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Text('$amountSpent'),
          RotatedBox(
              quarterTurns: -1,
              child: LinearPercentIndicator(
                width: 100.0,
                percent: percentage,
                progressColor: Colors.purple,
              )),
          Text(
              '${DateFormat('EEEE').format(widget.dayOfTheWeek).substring(0, 1)}'),
        ],
      ),
    );
  }
}

class DayExpenditure extends StatefulWidget {
  final DateTime dayOfTheWeek;

  DayExpenditure(
      {Key key, this.dayOfTheWeek})
      : super(key: key);

  @override
  DayExpenditureState createState() {
    return DayExpenditureState();
  }
}
