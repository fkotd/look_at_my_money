import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('welcome !!');
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 170.0,
          height: 170.0,
          child: ClipOval(
            child: Container(
              color: Theme.of(context).primaryColorLight,
              child: Image(
                image: AssetImage('assets/default_group.png'),
              ),
            ),
          ),
        ),
        Text(
          'You don’t have any groups. Start by creating one or by getting invited !',
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
