import 'package:flutter/material.dart';
import 'package:look_at_my_money/screens/expenses_screen.dart';
import 'package:look_at_my_money/screens/sign_in_screen.dart';
import 'package:look_at_my_money/screens/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(LookAtMyMoneyApp());
}

class LookAtMyMoneyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Look At My Money',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('error'); // TODO
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return _Home();
          }

          return Text('loading'); // TODO
        },
      ),
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
      return ExpensesScreen();
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
