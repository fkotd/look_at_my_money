import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:look_at_my_money/app_theme.dart';
import 'package:look_at_my_money/screens/drawer_screen.dart';
import 'package:look_at_my_money/screens/group_screen.dart';
import 'package:look_at_my_money/screens/sign_in_screen.dart';
import 'package:look_at_my_money/screens/sign_up_screen.dart';
import 'package:look_at_my_money/providers/auth_providers.dart';
import 'package:look_at_my_money/providers/data_providers.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.blueGrey[900],
  ));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: LookAtMyMoneyApp()));
}

class LookAtMyMoneyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Look At My Money',
      theme: AppTheme.themeData,
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
  bool _showSignIn = true;

  void _toggleShowSignIn() {
    setState(() => _showSignIn = !_showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final currentUser = watch(AuthProviders.currentUserProvider);

        return currentUser.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => const Text('Ono'),
          data: (currentUser) {
            if (currentUser != null) {
              return Stack(
                children: <Widget>[
                  DrawerScreen(),
                  GroupScreen(),
                ],
              );
            } else if (_showSignIn) {
              return SignInScreen(
                switchToSignUp: _toggleShowSignIn,
              );
            } else {
              return SignUpScreen(
                switchToSignIn: _toggleShowSignIn,
              );
            }
          },
        );
      },
    );
  }
}
