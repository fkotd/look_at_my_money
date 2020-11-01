import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/models/group.dart';
import 'package:look_at_my_money/providers/data_providers.dart';
import 'package:look_at_my_money/screens/group_screen.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({Key key, this.group}) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    final cardPadding = 10.0;

    return Consumer(builder: (context, watch, child) {
      return InkWell(
        splashColor: Theme.of(context).cardColor.withAlpha(30),
        onTap: () {
          context.read(DataProviders.groupIdProvider).changeGroup(group.id);
        },
        child: Card(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: EdgeInsets.only(top: cardPadding, bottom: cardPadding),
            child: ListTile(
              leading: ClipOval(
                child: Container(
                  color: Theme.of(context).primaryColorLight,
                  child: Image(
                    image: AssetImage('assets/default_group.png'),
                  ),
                ),
              ),
              title: Text(
                group.name,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ),
        ),
      );
    });
  }
}
