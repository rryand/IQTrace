class User {
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? email;
  String? birthday;
  Map<String, dynamic>? survey;
  bool isAdmin;

  String get name {
    return firstName! + ' ' + lastName!;
  }

  User({
    this.firstName,
    this.lastName,
    this.birthday,
    this.contactNumber,
    this.email,
    this.survey,
    this.isAdmin = false
  });

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'birthday': birthday,
    'contact_number': contactNumber,
    'email': email,
    'is_admin': isAdmin,
    'survey': survey != null ? survey : {},
  };

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      firstName: user['first_name'],
      lastName: user['last_name'],
      birthday: user['birthday'],
      contactNumber: user['contact_number'],
      email: user['email'],
      // TODO: add logic for isAdmin
      isAdmin: user['is_admin'] != null ? user['is_admin'] : false,
      survey: user['survey'],
    );
  }
}
