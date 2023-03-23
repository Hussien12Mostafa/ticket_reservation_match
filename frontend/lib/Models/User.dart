class User {
  String id;
  String userName;
  String firstName;
  String lastName;
  String nationality;
  String dateOfBirth;
  String gender;
  String role;
  String email;
  User({
    this.id,
    this.userName,
    this.firstName,
    this.lastName,
    this.nationality,
    this.dateOfBirth,
    this.gender,
    this.role,
    this.email,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      userName: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      nationality: json["nationality"],
      dateOfBirth: json["birthdate"],
      gender: json["gender"],
      role: json["role"],
      email: json["email"],
    );
  }
}
