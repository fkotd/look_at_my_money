import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/models/user.dart';
import 'package:look_at_my_money/providers/data_providers.dart';
import 'package:look_at_my_money/widgets/expense_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key key, this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final expenses = watch(DataProviders.userAllExpensesProvider(user));

          // TODO: refactor code with ExpenseList
          return expenses.when(
            loading: () => const CircularProgressIndicator(),
            // TODO: handle error with something else
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
      ),
    );
  }
}
