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
          loading: () => const SliverToBoxAdapter(
            child: const CircularProgressIndicator(),
          ),
          // TODO: handle error with something else ?
          error: (error, stack) => const SliverToBoxAdapter(
            child: const Text('Ono'),
          ),
          data: (users) {
            return SliverGrid.count(
              crossAxisCount: 2,
              children: <Widget>[
                for (var user in users) SumCard(user: user, group: group),
              ],
            );
          },
        );
      },
    );
  }
}
