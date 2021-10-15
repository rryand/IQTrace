import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/networking/api_base_helper.dart';

class UserRepository {
  ApiBaseHelper _api = ApiBaseHelper();

  Future<User> getUser(String token) async {
    // TODO: add token for auth
    final response = await _api.get('/users/me');
    final _user = User.fromJson(response);
    return _user;

    // To simulate api call and response
    /* return Future.delayed(
      const Duration(seconds: 2),
      () {
        return User(
          firstName: 'Ramses Ryan',
          lastName: 'Dineros',
          birthday: '1996-09-16',
          contactNumber: '09294137458',
          email: 'ramsesryandineros@gmail.com',
          isAdmin: true,
          survey: {}
        );
      },
    ); */
  }

  Future<List<User>?> getUsersWithActiveSymptoms(String token) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        return [
          User(
            firstName: 'Ryan',
            lastName: 'Dineros',
            birthday: '1996-09-16',
            contactNumber: '09294137458',
            email: 'ramsesryandineros@gmail.com',
            isAdmin: true,
            survey: {'test': true}
          ),
          User(
            firstName: 'Ramses',
            lastName: 'De Leon',
            birthday: '1999-09-10',
            contactNumber: '09994138541',
            email: 'rrddineros@gmail.com',
            isAdmin: true,
            survey: {'test': true, 'test2': true}
          ),
          User(
            firstName: 'John',
            lastName: 'Smith',
            birthday: '2001-03-26',
            contactNumber: '09196362386',
            email: 'jsmith@gmail.com',
            isAdmin: true,
            survey: {'test3': true}
          ),
        ];
      }
    );
  }

  Future<void> updateUser() {
    return Future.delayed(const Duration(seconds: 2));
  }
}
