import 'package:flutter/material.dart';
import 'package:look_at_my_money/models/expense.dart';
import 'package:look_at_my_money/models/user.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({Key key, this.expense, this.user}) : super(key: key);

  final Expense expense;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        dense: true,
        title: Text(
          user.name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: Text(
          expense.hint,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        // TODO: change storage(*100) and displaying(/100)
        trailing: Text(
          expense.value.toString(),
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
