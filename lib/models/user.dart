import 'package:iq_trace/services/helpers/date_helper.dart';

class User {
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? email;
  String? birthday;
  String? address;
  List<String>? survey;
  List? faceEncoding;
  bool isAdmin;
  bool isVerified;
  DateTime? lastSurveyDate;

  String get name {
    return firstName! + ' ' + lastName!;
  }

  User({
    this.firstName,
    this.lastName,
    this.birthday,
    this.contactNumber,
    this.email,
    this.address,
    this.survey,
    this.faceEncoding,
    this.isAdmin = false,
    this.isVerified = false,
    this.lastSurveyDate,
  });

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'birthday': birthday,
    'contact_number': contactNumber,
    'email': email,
    'address': address,
    'is_admin': isAdmin,
    'survey': survey != null ? survey : <String>[],
    'face_encoding': faceEncoding,
    'is_verified': isVerified,
    'last_survey_date': lastSurveyDate != null ? 
      DateHelper.formatDate(lastSurveyDate!) :
      null,
  };

  Map<String, dynamic> debugToJson() => {
    'email': email
  };

  factory User.fromJson(Map<String, dynamic> user) {
    user['survey'] = <String>[...user['survey']];
    return User(
      firstName: user['first_name'],
      lastName: user['last_name'],
      birthday: user['birthday'],
      contactNumber: user['contact_number'],
      email: user['email'],
      address: user['address'] != null ? user['address'] : 'n/a',
      faceEncoding: user['face_encoding'],
      // TODO: add logic for isAdmin
      isAdmin: user['is_admin'] != null ? user['is_admin'] : false,
      survey: user['survey'],
      isVerified: user['is_verified'] != null ? user['is_verified'] : false,
      lastSurveyDate: user['last_survey_date'] != null ? 
        DateHelper.fromString(user['last_survey_date']) : 
        null,
    );
  }
}
