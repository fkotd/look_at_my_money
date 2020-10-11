import 'package:flutter/material.dart';
import 'package:look_at_my_money/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key key,
    this.switchToSignIn,
  }) : super(key: key);

  final Function() switchToSignIn;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordVerificationController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordVerificationController.dispose();
    super.dispose();
  }

  final _signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sign Up'),
      ),
      body: Form(
        key: _signUpFormKey,
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email address',
                border: OutlineInputBorder(),
              ),
              controller: emailController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field is required.';
                }

                return null;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              controller: passwordController,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field is required.';
                }

                return null;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password (verification)',
                border: OutlineInputBorder(),
              ),
              controller: passwordVerificationController,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field is required.';
                }
                if (passwordVerificationController.text !=
                    passwordController.text) {
                  return 'Passworlds do not match.';
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
                  child: Text('I already have an account'),
                  onPressed: widget.switchToSignIn,
                ),
                ElevatedButton(
                  child: Text('Sign Up'),
                  onPressed: () async {
                    if (_signUpFormKey.currentState.validate()) {
                      await AuthService().signUp(
                          emailController.text, passwordController.text);
                      // TODO: add email verification
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
