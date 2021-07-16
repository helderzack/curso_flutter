import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DayExpenditureState extends State<DayExpenditure> {
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: -1,
      child: LinearPercentIndicator(
        width: 100.0,
        percent: 0.0,
        progressColor: Colors.purple,
      )
    );
  }
}

class DayExpenditure extends StatefulWidget {
  @override
  DayExpenditureState createState() {
    return DayExpenditureState();
  }
}
