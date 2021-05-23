import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:iq_trace/services/auth_service.dart';
import '../services/user_service.dart';
import '../services/storage_service.dart';

class IQTUser {
  String uid;
  String firstName;
  String lastName;
  String contactNumber;
  String email;
  String birthday;
  String localImagePath;
  bool isAdmin;
  List symptoms;

  String get name {
    return firstName + ' ' + lastName;
  }

  IQTUser({
    this.uid = '',
    this.firstName = '',
    this.lastName = '',
    this.birthday = '',
    this.contactNumber = '',
    this.email = '',
    this.localImagePath = '',
    this.isAdmin = false,
    this.symptoms = const [],
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'firstName': firstName,
    'lastName': lastName,
    'birthday': birthday,
    'contactNumber': contactNumber,
    'email': email,
    'localImagePath': localImagePath,
    'isAdmin': isAdmin,
    'symptoms': symptoms,
  };

  factory IQTUser.fromSnapshot(DocumentSnapshot snapshot) => IQTUser(
    uid: snapshot.get('uid'),
    firstName: snapshot.get('firstName'),
    lastName: snapshot.get('lastName'),
    birthday: snapshot.get('birthday'),
    contactNumber: snapshot.get('contactNumber'),
    email: snapshot.get('email'),
    localImagePath: snapshot.get('localImagePath'),
    isAdmin: snapshot.get('isAdmin'),
    symptoms: snapshot.get('symptoms'),
  );

  Future<bool> save(context, String password) async {
    final _authService = AuthService();
    final _userService = UserService();
    final _storageService = StorageService();

    try {
      final UserCredential userCredential = await _authService
          .createUser(email, password);
      uid = userCredential.user!.uid;
      print('UID: $uid');
      await _userService.uploadUserInfo(uid, this.toJson());
      await _storageService.uploadImage(uid, localImagePath);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
