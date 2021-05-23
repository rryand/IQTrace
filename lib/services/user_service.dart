import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iq_trace/models/user.dart';
import 'auth_service.dart';

class UserService {
  static const FIRESTORE_USERS_PATH = 'users';
  
  CollectionReference get _usersReference {
    return FirebaseFirestore.instance.collection(FIRESTORE_USERS_PATH);
  }

  Future<void> uploadUserInfo(String uid, Map<String, dynamic> user) async {
    try {
      print('uploading user info...');
      CollectionReference users = _usersReference;
      return await users.doc(uid).set(user);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<IQTUser> getUserInfo() async {
    var user = await AuthService().currentUser();
    DocumentSnapshot userSnapshot = await _usersReference.doc(user!.uid).get();
    return IQTUser.fromSnapshot(userSnapshot);
  }

  Future<void> updateUserSymptoms(Map<String, dynamic> symptomUpdate) async {
    var user = await AuthService().currentUser();
    try {
      CollectionReference users = _usersReference;
      return await users.doc(user!.uid).update(symptomUpdate);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
