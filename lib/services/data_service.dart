import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/models/user.dart';

class DataService {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference _groups = _firestore.collection('groups');
  static CollectionReference _users = _firestore.collection('users');

  final String _currentUser;

  DataService(this._currentUser);

  void createGroup(Group group) async {
    await _groups.add(group.toMap());
  }

  Stream<List<Group>> getGroupsOfCurrentUser() {
    return _groups
        .where('usersId', arrayContains: this._currentUser)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs
          .map(
            (doc) => Group(doc.id, doc['name'], doc['usersId'].cast<String>()),
          )
          .toList();
    });
  }

  Stream<List<User>> getUsersOfGroup(Group group) {
    return _users
        .where(FieldPath.documentId, whereIn: group.usersId)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs
          .map((doc) => User(doc.id, doc['name']))
          .toList();
    });
  }
}
