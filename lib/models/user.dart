class User {
  final String id;
  final String name;

  User({this.id, this.name});

  // TODO: move that in a provider
  // double get expensesSum {
  // return this
  // .expenses
  // .map((e) => e.expenses)
  // .fold(0, (previous, current) => previous + current);
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
