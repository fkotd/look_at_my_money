import 'package:flutter/material.dart';
import 'package:look_at_my_money/models/expense.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({Key key, this.expense}) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(children: <Widget>[
        Expanded(
          child: Text(expense.value.toString()),
        ),
        Expanded(
          child: Text(expense.hint),
        ),
      ]),
    );
  }
}
