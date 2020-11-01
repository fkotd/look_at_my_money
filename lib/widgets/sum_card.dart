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
        .fold(0.0, (previous, current) => previous + current);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final expenses = watch(
          DataProviders.userExpensesProvider(
            UserGroupParam(user: user, group: group),
          ),
        );
        return expenses.when(
          // TODO: loading and error
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) {
            print(error.toString());
            Text('Ono!');
          },
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 5.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        user.name,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Spacer(),
                      Text(
                        _sum(expenses).toString(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Spacer(),
                    ],
                  ), // Colomn
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
