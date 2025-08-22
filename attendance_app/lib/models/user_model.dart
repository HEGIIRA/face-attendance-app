class UserModel {
  final String email;
  final String bidang;

  UserModel({
    required this.email,
    required this.bidang,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      bidang: map['bidang'] ?? '',
    );
  }
}
