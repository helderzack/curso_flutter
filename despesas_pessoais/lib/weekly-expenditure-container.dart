import 'package:flutter/material.dart';

import './day-expenditure.dart';

List<GlobalKey<DayExpenditureState>> daylyExpenditureKey =
    List<GlobalKey<DayExpenditureState>>.generate(7, (index) => GlobalKey());

class WeeklyExpenditureContainerState
    extends State<WeeklyExpenditureContainer> {
  double weeklyAmountSpent = 0.0;
  final _daysOfTheWeek = List<DayExpenditure>.generate(
      7,
      (index) => DayExpenditure(
          key: daylyExpenditureKey.elementAt(index),
          dayOfTheWeek: DateTime.now().add(Duration(days: index))));
  final totalExpenditure = 0.0;

  void updateWeeklyExpenditureState(DateTime selectedDate, double amountSpent) {
    weeklyAmountSpent += amountSpent;

    print('Weekly spent: $weeklyAmountSpent');

    Key key = _daysOfTheWeek
        .firstWhere((element) =>
            element.dayOfTheWeek.weekday.compareTo(selectedDate.weekday) == 0)
        .key;

    daylyExpenditureKey
        .firstWhere((element) => element.hashCode.compareTo(key.hashCode) == 0)
        .currentState
        .addExpense(amountSpent);

    daylyExpenditureKey.forEach((element) {
      element.currentState.adjustPercentage(
          calculatePercentage(element.currentState.amountSpent));
    });
  }

  void removeExpenditure(DateTime registerDate, double value) {
    weeklyAmountSpent -= value;

    print('Weekly spent: $weeklyAmountSpent');

    Key key = _daysOfTheWeek
        .firstWhere((element) =>
            element.dayOfTheWeek.weekday.compareTo(registerDate.weekday) == 0)
        .key;

    daylyExpenditureKey
        .firstWhere((element) => element.hashCode.compareTo(key.hashCode) == 0)
        .currentState
        .subtractExpense(value);

    daylyExpenditureKey.forEach((element) {
      element.currentState.adjustPercentage(
          calculatePercentage(element.currentState.amountSpent));
    });
  }

  double calculatePercentage(double amountSpent) {
    if (amountSpent == 0) return 0.0;
    return ((amountSpent * 100) / weeklyAmountSpent) / 100;
  }

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20, bottom: 30),
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
  WeeklyExpenditureContainer({Key key}) : super(key: key);

  @override
  WeeklyExpenditureContainerState createState() {
    return WeeklyExpenditureContainerState();
  }
}
