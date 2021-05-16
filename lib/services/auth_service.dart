import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future register(String email, String password) async {
    try {
      await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }
}
