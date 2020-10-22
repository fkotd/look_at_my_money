import 'package:look_at_my_money/models/expenses.dart';

class Group {
  final String id;
  final String name;
  final List<String> usersId;

  Group(this.id, this.name, this.usersId);

  void addUserId(String userId) {
    this.usersId.add(userId);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'usersId': usersId,
    };
  }
}
