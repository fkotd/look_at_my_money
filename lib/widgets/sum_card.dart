import 'package:flutter/material.dart';
import 'package:look_at_my_money/models/user.dart';

class SumCard extends StatelessWidget {
  const SumCard({Key key, this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped');
        },
        child: Container(
          width: 300,
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(user.name),
              // FIXME: call the provider
              // Text('${widget.user.expensesSum}'),
            ],
          ),
        ),
      ),
    );
  }
}
