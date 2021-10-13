import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/networking/api_response.dart';
import 'package:iq_trace/services/auth_repository.dart';
import 'package:iq_trace/services/secure_storage_service.dart';
import 'package:iq_trace/services/user_repository.dart';

class AuthService {
  final _userRepo = UserRepository.instance;
  final _authRepo = AuthenticationRepository();
  final _storage = SecureStorageService.instance;

  Future<ApiResponse<User?>> getUser() async {
    try {
      final token = await _storage.readAccessToken();
      final user = token != null ? await _userRepo.getUser(token) : null;
      return ApiResponse.completed(user);
    } catch (e) {
      print(e);
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<User?>> signIn(String email, String password) async {
    try {
      final token = await _authRepo.login(email: email, password: password);
      final user = await _userRepo.getUser(token);
      return ApiResponse.completed(user);
    } catch (e) {
      print(e);
      return ApiResponse.error(e.toString());
    }
  }

  Future<void> signOut() async {
    await _storage.deleteAccessToken();
  }
}
