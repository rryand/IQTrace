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

/* import 'package:iq_trace/models/token.dart';
import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/exceptions.dart';
import '../networking/api_base_helper.dart';
import 'secure_storage_service.dart';

// TODO: add auto-refresh token
class AuthService {
  static AuthService? _instance;

  User? _currentUser;

  static AuthService get instance {
    if (_instance == null) {
      _instance = AuthService();
    }

    return _instance!;
  }

  User? get currentUser {
    return _currentUser;
  }

  //APIService get api {
  //  return APIService.getInstance();
  //}

  SecureStorageService get storage {
    return SecureStorageService.getInstance();
  }

  // TODO: DRY?
  Future<User?> initialize() async {
    String? token;

    token = await storage.readAccessToken();
    if (token == null) {
      return null;
    }

    try {
      await fetchUser(token);
    } on UnauthorizedHttpError catch (e) {
      print(e.toString());
      return null;
    }

    return _currentUser;
  }

  Future<User> fetchUser(String token) async {
    //Map<String, dynamic> userData = await api.getUser(token);
    //print(userData);
    //_currentUser = User.fromJson(userData);
    return _currentUser!;
  }

  Future<void> register(User user, String password) async {
    try {
      Map<String, dynamic> userData = user.toJson();
      //await api.register({ ...userData, 'password': password });
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> updateFaceEncoding(String imagePath) async {
    try {
      String token = await storage.readAccessToken() as String;
      //await api.uploadFaceImage(imagePath, token);
    } catch(e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    //Map<String, dynamic> tokenData = await api.login(email, password);
    //Token token = Token.fromJson(tokenData);
    
    //if (token.tokenType == 'bearer') {
    //  await storage.storeAccessToken(token.accessToken);
    //  await fetchUser(token.accessToken);
    //} else {
    //  throw InvalidTokenType('Invalid token type.');
    //}
  }

  // TODO: refactor signOut
  Future<bool> signOut() async {
    try {
      //await FirebaseAuth.instance.signOut();
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }
}
 */