import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/networking/api_base_helper.dart';
import 'package:iq_trace/services/user_repository.dart';

class UserService {
  static UserService? _instance;

  User? _user;

  ApiBaseHelper _api = ApiBaseHelper();
  UserRepository _userRepo = UserRepository();

  static UserService get instance {
    if (_instance == null) {
      _instance = UserService();
    }

    return _instance!;
  }

  User get currentUser {
    return _user!;
  }

  Future<User?> getUser(String token) async {
    if (_user != null) return _user!;

    _user = await _userRepo.getUser(token);
    return _user;
  }

  Future<List<User>?> getUsersWithActiveSymptoms() async {
    return await _userRepo.getUsersWithActiveSymptoms('token');
  }
  
  Future<void> updateUserSymptoms(Map survey) async {
    return await _userRepo.updateUser();
  }
}