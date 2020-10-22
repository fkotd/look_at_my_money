import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:look_at_my_money/models/user.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/providers/data_providers.dart';
import 'package:look_at_my_money/widgets/expenses_card.dart';

class GroupScreen extends StatefulWidget {
  final Group group;

  GroupScreen({Key key, this.group}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
      ),
      body: Container(
        child: Consumer(
          builder: (context, watch, child) {
            final users =
                watch(DataProviders.usersOfGroupProvider(widget.group));
            return users.when(
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Center(child: Text('ono')),
                data: (users) {
                  return GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      for (var user in users) ExpensesCard(user),
                    ],
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createExpenses();
        },
        child: Icon(Icons.attach_money),
      ),
    );
  }

  Future<void> _createExpenses() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add expenses'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Pay your declarement doggy [̲̅\$̲̅(̲̅ ✧≖ ͜ʖ≖)̲̅\$̲̅]'),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expenses',
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'For what ?',
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Throw'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
          actions:
          <Widget>[
            TextButton(
              child: Text('Drop that'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ];
        });
  }
}
