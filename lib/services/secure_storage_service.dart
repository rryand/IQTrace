import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static SecureStorageService? _instance;

  late FlutterSecureStorage _storage;
  String? _token;

  static SecureStorageService get instance {
    if (_instance == null) {
      _instance = SecureStorageService();
      _instance!._storage = FlutterSecureStorage();
    }

    return _instance!;
  }

  String? get token {
    return _token;
  }

  Future<String?> readAccessToken() async {
    _token = await _storage.read(key: 'jwt');
    return _token;
  }

  Future<void> storeAccessToken(String token) async {
    await _storage.write(key: 'jwt', value: token);
    _token = token;
  }

  Future<void> deleteAccessToken() async {
    await _storage.delete(key: 'jwt');
  }

  // Debug functions
  Future<void> debugDeleteAll() async {
    return await _storage.deleteAll();
  }
}
