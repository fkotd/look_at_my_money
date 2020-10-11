import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/services/data_service.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final groupNameController = TextEditingController();

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  void _createGroup() {
    Group group = Group(groupNameController.text);
    group.addUserId(FirebaseAuth.instance.currentUser.uid);
    DataService.createGroup(group);
  }

  Future<void> _showForm(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Create a new group'),
            content: TextField(
              decoration: InputDecoration(
                labelText: 'Enter the name of the group',
              ),
              controller: groupNameController,
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Submit'),
                onPressed: () {
                  _createGroup();
                },
              ),
            ],
            elevation: 24.0,
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group page'),
      ),
      body: Center(
        child: Text('You have no group.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _createGroup();
          _showForm(context);
        },
        child: Icon(Icons.group_add),
      ),
    );
  }
}
