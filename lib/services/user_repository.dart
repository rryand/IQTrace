import 'dart:convert';

import 'package:iq_trace/models/user.dart';
import 'package:iq_trace/networking/api_base_helper.dart';

class UserRepository {
  ApiBaseHelper _api = ApiBaseHelper();

  Future<User> getUser(String token) async {
    final response = await _api.get('/users/me', token);
    final _user = User.fromJson(response);
    return _user;
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
            survey: ['test']
          ),
          User(
            firstName: 'Ramses',
            lastName: 'De Leon',
            birthday: '1999-09-10',
            contactNumber: '09994138541',
            email: 'rrddineros@gmail.com',
            isAdmin: true,
            survey: ['test', 'test2']
          ),
          User(
            firstName: 'John',
            lastName: 'Smith',
            birthday: '2001-03-26',
            contactNumber: '09196362386',
            email: 'jsmith@gmail.com',
            isAdmin: true,
            survey: ['test3']
          ),
        ];
      }
    );
  }

  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> userData, String token) async {
    return await _api.put('/users/me', userData, token);
  }
}
