import 'package:look_at_my_money/models/expenses.dart';

class User {
  final String id;
  final String name;
  final List<Expenses> expensesHistory = [];

  User(this.id, this.name);

  void addExpensesToHistory(Expenses expenses) {
    this.expensesHistory.add(expenses);
  }

  double get expensesSum {
    return this
        .expensesHistory
        .map((e) => e.expenses)
        .fold(0, (previous, current) => previous + current);
  }
}
