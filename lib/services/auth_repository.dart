import 'dart:async';

import 'package:iq_trace/networking/api_base_helper.dart';

import './secure_storage_service.dart';

class AuthenticationRepository {
  final _storage = SecureStorageService.instance;
  final _api = ApiBaseHelper();

  Future<String> login({required String email, required String password}) async {
    final response = await _api.postForm('/users/login', {
      'username': email,
      'password': password,
    });
    return response['access_token'];
  }

  Future<void> logout() async {
    await _storage.debugDeleteAll(); // TODO: delete token only
  }

  Future<void> register(Map<String, dynamic> body) async {
    await _api.post('/users/register', body);
  }

  Future<void> sendVerificationEmail(String email) async {
    await _api.post('/verification?email=$email');
  }
}
