import 'package:flutter/material.dart';
import 'package:look_at_my_money/models/user.dart';

class ExpensesCard extends StatefulWidget {
  User user;

  ExpensesCard(this.user);

  @override
  _ExpensesCardState createState() => _ExpensesCardState();
}

class _ExpensesCardState extends State<ExpensesCard> {
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
