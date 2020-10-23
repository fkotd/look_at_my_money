class Expense {
  final String id;
  final String groupId;
  final double value;
  final String hint;
  final DateTime date;
  // Add categories to expense ?

  Expense({this.id, this.groupId, this.value, this.hint, this.date});

  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId,
      'value': value,
      'hint': hint,
      'date': date,
    };
  }
}
