class User {
  final int _month;
  final int _day;
  final int _year;

  final String firstName;
  final String lastName;
  final String contactNumber;
  final String email;
  final String portraitUrl;
  final bool isAdmin;

  String get name {
    return firstName + ' ' + lastName;
  }

  String get birthday {
    return '$_month/$_day/$_year';
  }

  User(
    this.firstName,
    this.lastName,
    this._month,
    this._day,
    this._year,
    this.contactNumber,
    this.email,
    this.portraitUrl,
    this.isAdmin,
  );

  Map<String, dynamic> toJson() => {
    'fullName': name,
    'contactNumber': contactNumber,
    'email': email,
    'birthday': birthday,
    'portraitUrl': portraitUrl,
  };
}
