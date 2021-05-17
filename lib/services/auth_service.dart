import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(text)));
  }

  Future<bool> register(BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      _showSnackBar(context, 'Successfully registered!');
      return true;
    } catch (e) {
      print(e.toString());
      _showSnackBar(context, e.toString());
      return false;
    }
  }

  Future<bool> signIn(BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _showSnackBar(context, 'Signed in successfully!');
      return true;
    } catch (e) {
      print(e.toString());
      _showSnackBar(context, e.toString());
      return false;
    }
  }

  Future<bool> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      _showSnackBar(context, 'Signed out successfully!');
      return true;
    } catch(e) {
      print(e.toString());
      _showSnackBar(context, e.toString());
      return false;
    }
  }
}
