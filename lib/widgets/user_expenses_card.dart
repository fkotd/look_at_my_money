import 'package:flutter/material.dart';
import 'package:look_at_my_money/models/user.dart';

class UserExpensesCard extends StatefulWidget {
  User user;

  UserExpensesCard(this.user);

  @override
  _UserExpensesCardState createState() => _UserExpensesCardState();
}

class _UserExpensesCardState extends State<UserExpensesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
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
                Text('${widget.user.name}'),
                Text('${widget.user.expensesSum}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
