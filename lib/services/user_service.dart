import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:iq_trace/models/user.dart';
import 'auth_service.dart';
import 'helpers/date_helper.dart';

class UserService {
  static const FIRESTORE_USERS_PATH = 'users';
  static const FIRESTORE_ROOMS_PATH = 'rooms';
  static const FIRESTORE_ROOM_RECORDS_PATH = 'records';
  static const FIRESTORE_USER_ROOM_RECORDS_PATH = 'roomRecords';
  
  CollectionReference get _users {
    return FirebaseFirestore.instance.collection(FIRESTORE_USERS_PATH);
  }

  CollectionReference _roomRecords(String roomId) {
    return FirebaseFirestore.instance.collection(FIRESTORE_ROOMS_PATH)
        .doc(roomId).collection(FIRESTORE_ROOM_RECORDS_PATH);
  }

  CollectionReference _userRoomRecords(String uid) {
    return _users.doc(uid).collection(FIRESTORE_USER_ROOM_RECORDS_PATH);
  }

  Future<void> uploadUserInfo(String uid, Map<String, dynamic> user) async {
    try {
      print('uploading user info...');
      return await _users.doc(uid).set(user);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<IQTUser> getUserInfo() async {
    var user = await AuthService().currentUser();
    DocumentSnapshot userSnapshot = await _users.doc(user!.uid).get();
    return IQTUser.fromSnapshot(userSnapshot);
  }

  Future<void> updateUserSymptoms(Map<String, dynamic> symptomUpdate) async {
    var user = await AuthService().currentUser();
    try {
      return await _users.doc(user!.uid).update(symptomUpdate);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // FireStore collections path for symptom update:
  //   rooms/{roomId}/records/{date}
  //     - users = [{uid}]
  //   users/{uid}/roomRecords/{date}
  //     - enteredRooms = [{roomId}]
  Future<void> updateRoomRecords(String roomId) async {
    var user = await AuthService().currentUser();
    print('uploading symptom update...');
    String currentDate = DateHelper.getCurrentDate();

    _updateUsersRoomRecord(user!.uid, roomId, currentDate);
    _updateRoomCollectionRecord(user.uid, roomId, currentDate);
  }

  Future<void> _updateUsersRoomRecord(String uid, String roomId, String date) async {
    DocumentSnapshot _record = await _userRoomRecords(uid).doc(date).get();
    print(_record.data());
    if (_record.data() == null) {
      print(_record.data());
      await _userRoomRecords(uid).doc(date).set({'enteredRooms': [roomId]});
    } else if (!_record.get('enteredRooms').contains(roomId)) {
      List _enteredRooms = [..._record.get('enteredRooms'), roomId];
      await _userRoomRecords(uid).doc(date).set({'enteredRooms': _enteredRooms});
    }
    print(_record.data());
  }

  Future<void> _updateRoomCollectionRecord(String uid, String roomId, String date) async {
    DocumentSnapshot _record = await _roomRecords(roomId).doc(date).get();
    print(_record.data());
    if (_record.data() == null) {
      print(_record.data());
      await _roomRecords(roomId).doc(date).set({'users': [uid]});
    } else if (!_record.get('users').contains(uid)) {
      List _users = [..._record.get('users'), uid];
      await _roomRecords(roomId).doc(date).set({'users': _users});
    }
    print(_record.data());
  }
}
