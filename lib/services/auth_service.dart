import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<UserCredential> createUser(String email, String password) async {
    try {
      print('creating user...');
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e.toString());
      rethrow;
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

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }

  Future<User?> currentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
