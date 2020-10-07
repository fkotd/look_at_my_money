import 'package:flutter/material.dart';
import 'package:look_at_my_money/models/user.dart';
import 'package:look_at_my_money/widgets/user_expenses_card.dart';

class ExpensesScreen extends StatefulWidget {
  // TODO: change with group name
  final title = 'Nichijou <3';

  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final users = [User("johyn"), User("math"), User("kegan")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          for (var user in users) UserExpensesCard(user),
        ],
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
