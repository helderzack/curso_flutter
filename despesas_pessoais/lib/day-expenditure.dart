import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DayExpenditureState extends State<DayExpenditure> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Text('${widget.amountSpent}'),
          RotatedBox(
              quarterTurns: -1,
              child: LinearPercentIndicator(
                width: 100.0,
                percent: widget.percentage,
                progressColor: Colors.purple,
              )),
          Text(widget.dayOfTheWeek)
        ],
      ),
    );
  }
}

class DayExpenditure extends StatefulWidget {
  double amountSpent;
  double percentage;
  String dayOfTheWeek;

  DayExpenditure(this.amountSpent, this.percentage, this.dayOfTheWeek);

  @override
  DayExpenditureState createState() {
    return DayExpenditureState();
  }
}
