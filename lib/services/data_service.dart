import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/models/user.dart';
import 'package:look_at_my_money/models/expense.dart';

class DataService {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference _groups = _firestore.collection('groups');
  static CollectionReference _users = _firestore.collection('users');

  final String _currentUser;

  DataService(this._currentUser);

  void createGroup(Group group) async {
    try {
      await _groups.add(group.toMap());
    } catch (err) {
      // TODO: handle error
    }
  }

  void createExpenses(Expense expense) async {
    try {
      await _users
          .doc(this._currentUser)
          .collection('expenses')
          .add(expense.toMap());
    } catch (err) {
      // TODO: handle error
    }
  }

  Stream<List<Group>> getCurrentUserGroups() {
    return _groups
        .where('usersId', arrayContains: this._currentUser)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Group(
                id: doc.id,
                name: doc['name'],
                usersId: doc['usersId'].cast<String>(),
              ))
          .toList();
    });
  }

  Stream<List<User>> getGroupUsers(Group group) {
    return _users
        .where(FieldPath.documentId, whereIn: group.usersId)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs
          .map((doc) => User(
                id: doc.id,
                name: doc['name'],
              ))
          .toList();
    });
  }

  Stream<List<Expense>> getGroupExpenses(Group group) {
    return _firestore
        .collectionGroup('expenses')
        .where('groupId', isEqualTo: group.id)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Expense(
                id: doc.id,
                groupId: doc['groupId'],
                value: doc['value'],
                hint: doc['hint'],
                date: doc['date'].toDate(),
              ))
          .toList();
    });
  }

  Stream<List<Expense>> getUserExpenses(Group group, User user) {
    return _users
        .doc(user.id)
        .collection('expenses')
        .where('groupId', isEqualTo: group.id)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Expense(
                id: doc.id,
                groupId: doc['groupId'],
                value: doc['value'],
                hint: doc['hint'],
                date: doc['date'].toDate(),
              ))
          .toList();
    });
  }

  Stream<List<Expense>> getUserAllExpenses(User user) {
    return _users
        .doc(user.id)
        .collection('expenses')
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Expense(
                id: doc.id,
                groupId: doc['groupId'],
                value: doc['value'],
                hint: doc['hint'],
                date: doc['date'].toDate(),
              ))
          .toList();
    });
  }
}
