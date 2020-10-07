import 'package:flutter/material.dart';
import 'package:look_at_my_money/screens/expenses_screen.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Look at my money',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: ExpensesScreen(),
    );
  }
}
