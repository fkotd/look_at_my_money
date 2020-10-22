import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/providers/auth_providers.dart';
import 'package:look_at_my_money/providers/data_providers.dart';
import 'package:look_at_my_money/services/data_service.dart';
import 'package:look_at_my_money/screens/group_screen.dart';

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final groupNameController = TextEditingController();

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  void _createGroup(BuildContext context) {
    final currentUser = context.read(AuthProviders.currentUserProvider);
    final dataService = context.read(DataProviders.dataServiceProvider);

    Group group = Group(null, groupNameController.text, []);
    group.addUserId(currentUser.data.value);
    dataService.createGroup(group);
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
                  _createGroup(context);
                  groupNameController.text = '';
                  Navigator.of(context).pop();
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
      body: Consumer(
        builder: (context, watch, child) {
          final groupsOfUsers =
              watch(DataProviders.groupsOfCurrentUserProvider);

          return groupsOfUsers.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) {
                print('here');
                print(error.toString());
                return const Text('ono'); // TODO
              },
              data: (groupsOfUsers) {
                return ListView(
                  children: [
                    for (var group in groupsOfUsers)
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GroupScreen(group: group)),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(group.name),
                          ),
                        ),
                      ),
                  ],
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showForm(context);
        },
        child: Icon(Icons.group_add),
      ),
    );
  }
}
