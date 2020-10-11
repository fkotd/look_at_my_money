import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // TODO: handle errors
      print(e);
    }
  }

  void signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      // TODO: handle errors
      print(e);
    }
  }

  void verifyEmail() async {
    User user = _auth.currentUser;

    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  void checkCode(String code) async {
    try {
      await _auth.checkActionCode(code);
      await _auth.applyActionCode(code);

      _auth.currentUser.reload();
    } catch (e) {
      // TODO: handle errors
      print(e);
    }
  }

  void deleteUser() async {
    try {
      await _auth.currentUser.delete();
    } catch (e) {
      // TODO: handle errors
      print(e);
    }
  }
}
