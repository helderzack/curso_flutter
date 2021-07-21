import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './day-expenditure.dart';

class WeeklyExpenditureContainerState
    extends State<WeeklyExpenditureContainer> {
  final _daysOfTheWeek =
      List<DayExpenditure>.generate(
        7, (index) => 
        DayExpenditure(
          0.0, 
          0.0, 
          DateFormat('EEEE').
            format(DateTime.now().
            add(Duration(days: index))
          ).substring(0, 1)
        )
      );
  final totalExpenditure = 0.0;

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 30),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _daysOfTheWeek[0],
            _daysOfTheWeek[1],
            _daysOfTheWeek[2],
            _daysOfTheWeek[3],
            _daysOfTheWeek[4],
            _daysOfTheWeek[5],
            _daysOfTheWeek[6]
          ],
        ),
        shadowColor: Colors.black,
        elevation: 4,
        color: Colors.white,
      ),
    );
  }
}

class WeeklyExpenditureContainer extends StatefulWidget {
  @override
  WeeklyExpenditureContainerState createState() {
    return WeeklyExpenditureContainerState();
  }
}
