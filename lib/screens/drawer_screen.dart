import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/app_theme.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/providers/auth_providers.dart';
import 'package:look_at_my_money/providers/data_providers.dart';
import 'package:look_at_my_money/services/data_service.dart';
import 'package:look_at_my_money/widgets/group_list.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final groupNameController = TextEditingController();

  // TODO: check that this is really necessary
  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  void _createGroup(BuildContext context) {
    final currentUser = context.read(AuthProviders.currentUserProvider);
    final dataService = context.read(DataProviders.dataServiceProvider);

    Group group = Group(
      name: groupNameController.text,
      usersId: [currentUser.data?.value],
    );
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final drawerWidth = screenSize.width - screenSize.width / 5;
    final drawerPadding = 10.0;
    final groupsListHeight = screenSize.height;
    final topOffset = MediaQuery.of(context).padding.top;
    final cornerRadius = Radius.circular(10.0);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Padding(
        padding: EdgeInsets.only(
          top: topOffset,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: cornerRadius,
          ),
          child: Container(
            width: drawerWidth,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: EdgeInsets.all(drawerPadding),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Groups',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      // TODO: add ink effect
                      IconButton(
                        icon: Icon(Icons.group_add_outlined),
                        color: Theme.of(context).primaryColorLight,
                        onPressed: () {
                          _showForm(context);
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: GroupList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
