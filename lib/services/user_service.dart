import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/networking/api_response.dart';
import 'package:iq_trace/services/secure_storage_service.dart';
import 'package:iq_trace/services/user_repository.dart';

class UserService {
  static UserService? _instance;

  User? _user;

  UserRepository _userRepo = UserRepository();
  SecureStorageService _storage = SecureStorageService.instance;

  static UserService get instance {
    if (_instance == null) {
      _instance = UserService();
    }

    return _instance!;
  }

  User get currentUser {
    return _user!;
  }

  void removeUser() {
    _user = null;
  }

  Future<User> getUser([String? token]) async {
    if (_user != null) return _user!;

    _user = await _userRepo.getUser(token != null ? token : _storage.token!);
    return _user!;
  }

  Future<List<User>?> getUsersWithActiveSymptoms() async {
    return await _userRepo.getUsersWithActiveSymptoms('token');
  }
  
  Future<ApiResponse<void>> updateUserSymptoms(Map survey) async {
    final symptoms = [];
    survey.forEach((key, value) {
      switch (key) {
        case 'isQuarantined':
          if (survey[key]) {
            symptoms.add(key);
          }
          break;
        case 'exposure':
        case 'symptoms':
          List exposure = survey[key];
          symptoms.addAll(exposure);
          break;
      }
    });

    try {
      final fetchedUser = await getUser(_storage.token!);
      final Map<String, dynamic> userToSend = fetchedUser.toJson();
      userToSend['survey'] = symptoms;

      final _userJson = await _userRepo.updateUser(userToSend, _storage.token!);
      _user = User.fromJson(_userJson);

      return ApiResponse.completed(null);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<void>> uploadFaceImage(String email, String imagePath) async {
    try {
      await _userRepo.uploadFaceImage(email, imagePath);
      return ApiResponse.completed(null);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return ApiResponse.error(e.toString());
    }
  }
}