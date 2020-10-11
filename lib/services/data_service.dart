import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:look_at_my_money/models/group.dart';

class DataService {
  static FirebaseFirestore _instance = FirebaseFirestore.instance;
  static CollectionReference _groups = _instance.collection('groups');

  static void createGroup(Group group) async {
    _groups.add(group.toMap());
  }
}
