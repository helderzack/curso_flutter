import 'package:flutter/material.dart';

import './day-expenditure.dart';

class WeeklyExpenditureContainerState
    extends State<WeeklyExpenditureContainer> {
  final _daysOfTheWeek =
      List<DayExpenditure>.generate(7, (index) => DayExpenditure());

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 30),
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
