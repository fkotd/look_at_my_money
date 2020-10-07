import 'package:flutter/material.dart';
import 'package:look_at_my_money/screens/sign_in_screen.dart';
import 'package:look_at_my_money/screens/sign_up_screen.dart';

void main() {
  runApp(LookAtMyMoneyApp());
}

class LookAtMyMoneyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Look At My Money',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  bool _isAuthenticated = false;
  bool _showSignIn = true;

  void _toggleShowSignIn() {
    setState(() => _showSignIn = !_showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (_isAuthenticated) {
      return Text('home');
    }

    if (_showSignIn) {
      return SignInScreen(
        switchToSignUp: _toggleShowSignIn,
        onSignIn: () {
          setState(() => _isAuthenticated = true);
        },
      );
    } else {
      return SignUpScreen(
        switchToSignIn: _toggleShowSignIn,
      );
    }
  }
}
