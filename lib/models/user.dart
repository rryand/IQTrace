class IQTUser {
  final int _month;
  final int _day;
  final int _year;

  final String firstName;
  final String lastName;
  final String contactNumber;
  final String email;
  final String portraitUrl;
  final bool isAdmin;
  final List symptoms;

  String get name {
    return firstName + ' ' + lastName;
  }

  String get birthday {
    return '$_month/$_day/$_year';
  }

  IQTUser(
    this.firstName,
    this.lastName,
    this._month,
    this._day,
    this._year,
    this.contactNumber,
    this.email,
    this.portraitUrl,
    this.isAdmin,
    [this.symptoms = const []]
  );

  Map<String, dynamic> toJson() => {
    'fullName': name,
    'contactNumber': contactNumber,
    'email': email,
    'birthday': birthday,
    'portraitUrl': portraitUrl,
  };
}
