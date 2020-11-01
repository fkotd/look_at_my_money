import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/providers/data_providers.dart';
import 'package:look_at_my_money/screens/group_screen.dart';
import 'package:look_at_my_money/widgets/group_card.dart';

class GroupList extends StatelessWidget {
  const GroupList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final groupsOfUsers = watch(DataProviders.currentUserGroupsProvider);

        return groupsOfUsers.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => const Text('Ono!'),
          data: (groupsOfUsers) {
            return ListView(
              children: [
                for (var group in groupsOfUsers) GroupCard(group: group),
              ],
            );
          },
        );
      },
    );
  }
}
