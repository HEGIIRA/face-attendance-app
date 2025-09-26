class UserModel {
  final String email;
  final String division;

  UserModel({
    required this.email,
    required this.division,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      division: map['division'] ?? '',
    );
  }
}
