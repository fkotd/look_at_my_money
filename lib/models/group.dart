import 'package:look_at_my_money/models/expenses.dart';

class Group {
  String _name;
  List<String> _userIds = [];

  Group(this._name);

  void addUserId(String userId) {
    this._userIds.add(userId);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'userIds': _userIds,
    };
  }
}
