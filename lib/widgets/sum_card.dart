import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/models/user.dart';
import 'package:look_at_my_money/models/user_group_param.dart';
import 'package:look_at_my_money/providers/data_providers.dart';
import 'package:look_at_my_money/screens/history_screen.dart';

class SumCard extends StatelessWidget {
  const SumCard({Key key, this.user, this.group}) : super(key: key);

  final User user;
  final Group group;

  double _sum(expenses) {
    return expenses
        .map((e) => e.value)
        .fold(0, (previous, current) => previous + current);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final expenses = watch(DataProviders.userExpensesProvider(
        UserGroupParam(user: user, group: group),
      ));

      return expenses.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Ono!'),
        data: (expenses) => Card(
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HistoryScreen(user: user)),
              );
            },
            child: Container(
              width: 300,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(user.name),
                  Text(_sum(expenses).toString()),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
