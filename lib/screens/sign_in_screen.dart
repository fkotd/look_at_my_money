import 'package:flutter/material.dart';
import 'package:look_at_my_money/services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key key,
    this.switchToSignUp,
  }) : super(key: key);

  final Function() switchToSignUp;

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sign In'),
      ),
      body: Form(
        key: _signInFormKey,
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            TextFormField(
              controller: emailController,
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
              controller: passwordController,
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
                  onPressed: widget.switchToSignUp,
                ),
                ElevatedButton(
                  child: Text('Sign In'),
                  onPressed: () async {
                    if (_signInFormKey.currentState.validate()) {
                      await AuthService().signIn(
                          emailController.text, passwordController.text);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
