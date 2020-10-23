import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/providers/data_providers.dart';
import 'package:look_at_my_money/widgets/expense_card.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({Key key, this.group}) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final expenses = watch(DataProviders.groupExpensesProvider(group));

        return expenses.when(
          loading: () => const CircularProgressIndicator(),
          // TODO: handle error with something else ?
          error: (error, stack) => Center(child: Text(error.toString())),
          data: (expenses) {
            print(expenses);
            return ListView(
              children: <Widget>[
                for (var expense in expenses) ExpenseCard(expense: expense),
              ],
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
            );
          },
        );
      },
    );
  }
}
