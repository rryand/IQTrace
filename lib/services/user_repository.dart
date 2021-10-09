import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/networking/api_base_helper.dart';

class UserRepository {
  static UserRepository? _instance;

  User? _user;

  ApiBaseHelper _api = ApiBaseHelper();

  static UserRepository get instance {
    if (_instance == null) {
      _instance = UserRepository();
    }

    return _instance!;
  }

  User get currentUser {
    return _user!;
  }

  Future<User?> getUser(String token) async {
    if (_user != null) return _user!;

    // TODO: add token for auth
    //final response = await _api.get('/users/me');
    //_user = User.fromJson(response);
    //return _user;

    // To simulate api call and response
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        _user = User(
          firstName: 'Ryan',
          lastName: 'Dineros',
          birthday: '1996-09-16',
          contactNumber: '09294137458',
          email: 'ramsesryandineros@gmail.com',
          isAdmin: false,
          survey: {}
        );
        return _user!;
      },
    );
  }
}
