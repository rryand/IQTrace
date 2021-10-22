import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/networking/api_base_helper.dart';

class UserRepository {
  ApiBaseHelper _api = ApiBaseHelper();

  Future<User> getUser(String token) async {
    final response = await _api.get('/users/me', token);
    final _user = User.fromJson(response);
    return _user;
  }

  Future<List<User>?> getUsersWithActiveSymptoms(String token) async {
    final response = await _api.get('/users/active-symptoms') as List;
    final List<User> users = [];
    response.forEach((userJson) {
      users.add(User.fromJson(userJson));
    });

    return users;
  }

  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> userData, String token) async {
    return await _api.put('/users/me', userData, token);
  }

  Future<void> uploadFaceImage(String email, String imagePath) async {
    await _api.multipartPatch('/users/image-encoding?email=$email', imagePath);
  }
}
