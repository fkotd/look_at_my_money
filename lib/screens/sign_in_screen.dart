import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    Key key,
    this.switchToSignUp,
    this.onSignIn,
  }) : super(key: key);

  final Function() switchToSignUp;
  final Function() onSignIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sign In'),
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'Email address',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field is required';
                }

                return null;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field is required';
                }

                return null;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            ButtonBar(
              children: [
                OutlinedButton(
                  child: Text('I don\'t have an account'),
                  onPressed: switchToSignUp,
                ),
                ElevatedButton(
                  child: Text('Sign In'),
                  onPressed: onSignIn,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
