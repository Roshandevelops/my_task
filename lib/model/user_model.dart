class UserModel {
  final String? name;
  final String? userId;
  final String? mobile;
  final String? password;

  UserModel({
    required this.name,
    required this.userId,
    required this.mobile,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json["name"],
        userId: json["user_id"],
        mobile: json["mobile"],
        password: json["password"]);
  }
}
