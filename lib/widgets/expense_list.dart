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
        final groupUsers = watch(DataProviders.groupUsersProvider(group));

        if (expenses.data == null || groupUsers.data == null) {
          return const SliverToBoxAdapter(
            child: const CircularProgressIndicator(),
          );
        }
        return SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              for (var expense in expenses.data.value)
                ExpenseCard(
                  expense: expense,
                  user: groupUsers.data.value
                      .firstWhere((user) => user.id == expense.userId),
                ),
            ],
          ),
        );
      },
    );
  }
}
