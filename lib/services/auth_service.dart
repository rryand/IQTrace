import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<bool> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
