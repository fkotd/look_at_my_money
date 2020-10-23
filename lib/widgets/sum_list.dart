import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/providers/data_providers.dart';
import 'package:look_at_my_money/widgets/sum_card.dart';

class SumList extends StatelessWidget {
  const SumList({Key key, this.group}) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final users = watch(DataProviders.groupUsersProvider(group));

        return users.when(
          loading: () => const CircularProgressIndicator(),
          // TODO: handle error with something else ?
          error: (error, stack) => Center(child: Text('Ono !')),
          data: (users) {
            return GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                for (var user in users) SumCard(user: user),
              ],
              shrinkWrap: true,
            );
          },
        );
      },
    );
  }
}
