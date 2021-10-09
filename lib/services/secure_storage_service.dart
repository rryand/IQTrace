import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static SecureStorageService? _instance;

  late FlutterSecureStorage _storage;

  static SecureStorageService get instance {
    if (_instance == null) {
      _instance = SecureStorageService();
      _instance!._storage = FlutterSecureStorage();
    }

    return _instance!;
  }

  Future<String?> readAccessToken() async {
    //return await _storage.read(key: 'jwt'); // TODO: remove
    return 'test';
  }

  Future<void> storeAccessToken(String token) async {
    await _storage.write(key: 'jwt', value: token);
  }

  Future<void> deleteAccessToken() async {
    await _storage.delete(key: 'jwt');
  }

  // Debug functions
  Future<void> debugDeleteAll() async {
    return await _storage.deleteAll();
  }
}
