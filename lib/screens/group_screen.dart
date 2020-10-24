import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/models/expense.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/providers/data_providers.dart';
import 'package:look_at_my_money/widgets/sum_list.dart';
import 'package:look_at_my_money/widgets/expense_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupScreen extends StatefulWidget {
  final Group group;

  GroupScreen({Key key, this.group}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final valueController = TextEditingController();
  final hintController = TextEditingController();

  void _createExpenses(BuildContext context) {
    final dataService = context.read(DataProviders.dataServiceProvider);

    Expense expense = Expense(
      groupId: widget.group.id,
      value: double.parse(valueController.text),
      hint: hintController.text,
      date: new DateTime.now(),
    );

    dataService.createExpenses(expense);
  }

  Future<void> _showForm() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Show your money doggy'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: valueController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expenses',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: hintController,
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
                _createExpenses(context);
                valueController.text = '';
                hintController.text = '';
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _updateLastVisitedGroup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastVisitedString', group.id);
  }

  @override
  Widget build(BuildContext context) {
    _updateLastVisitedGroup();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group.name),
      ),
      body: Column(
        children: <Widget>[
          SumList(group: widget.group),
          ExpenseList(group: widget.group),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm();
        },
        child: Icon(Icons.attach_money),
      ),
    );
  }
}
