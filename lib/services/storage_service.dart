import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  String getImagePath(String uid, String localPath) {
    if (uid.isNotEmpty && localPath.isNotEmpty) {
      return 'images/$uid/${localPath.split('/').last}';
    } else {
      return '';
    }
  }

  Future uploadImage(String uid, String localPath) async {
    print('uploading image...');
    String _imagePath = getImagePath(uid, localPath);
    Reference _imageRef = FirebaseStorage.instance.ref(_imagePath);

    try {
      return await _imageRef.putFile(File(localPath));
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
