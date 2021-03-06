import 'package:iq_trace/exceptions.dart';
import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/networking/api_response.dart';
import 'package:iq_trace/services/auth_repository.dart';
import 'package:iq_trace/services/secure_storage_service.dart';
import 'package:iq_trace/services/user_service.dart';

class AuthService {
  final _userService = UserService.instance;
  final _authRepo = AuthenticationRepository();
  final _storage = SecureStorageService.instance;

  Future<ApiResponse<User?>> getUser() async {
    try {
      final token = await _storage.readAccessToken();
      final user = token != null ? await _userService.getUser(token) : null;
      return ApiResponse.completed(user);
    } on UnauthorizedHttpError catch (e) {
      print(e);
      return ApiResponse.completed(null);
    }
     catch (e) {
      print(e);
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<User?>> signIn(String email, String password) async {
    try {
      final token = await _authRepo.login(email: email, password: password);
      _storage.storeAccessToken(token);

      final user = await _userService.getUser(token);
      return ApiResponse.completed(user);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return ApiResponse.error(e.toString());
    }
  }

  Future<void> signOut() async {
    await _storage.deleteAccessToken();
    _userService.removeUser();
  }

  Future<ApiResponse<void>> register(User user, String password) async {
    try {
      Map<String, dynamic> userData = user.toJson();
      userData['password'] = password;
      await _authRepo.register(userData);

      return ApiResponse.completed(null);
    } catch(e, stacktrace) {
      print(e);
      print(stacktrace);
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<void>> sendVerificationEmail(String email) async {
    try {
      await _authRepo.sendVerificationEmail(email);
      return ApiResponse.completed(null);
    } on ForbiddenHttpError {
      return ApiResponse.completed(null);
    } catch(e, stacktrace) {
      print(e);
      print(stacktrace);
      return ApiResponse.error(e.toString());
    }
  }
}
