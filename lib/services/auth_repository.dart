import 'dart:async';

import 'package:iq_trace/networking/api_base_helper.dart';

import './secure_storage_service.dart';

class AuthenticationRepository {
  final _storage = SecureStorageService.instance;
  final _api = ApiBaseHelper();

  Future<String> login({required String email, required String password}) async {
    // TODO: integrate api login
    return await Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        final token = 'test';
        await _storage.storeAccessToken(token);
        // throw 'test login error'; // debug login error
        return token;
      },
    );
  }

  Future<void> logout() async {
    await _storage.debugDeleteAll(); // TODO: delete token only
  }
}
