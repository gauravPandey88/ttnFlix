class UserModel {
  late final String? userName;
  final String? emailAddress;
  final String? dateOfBirth;
  final String? password;
  final String? gender;
  final String? image;
  final bool? isLogin;

  UserModel(
      {this.userName,
      this.emailAddress,
      this.dateOfBirth,
      this.password,
      this.image,
      this.gender,
      this.isLogin});

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
        userName: parsedJson['userName'] ?? "",
        emailAddress: parsedJson['emailAddress'] ?? "",
        dateOfBirth: parsedJson['dateOfBirth'] ?? "",
        password: parsedJson['password'] ?? "",
        gender: parsedJson['gender'] ?? "",
        image: parsedJson['image'] ?? "",
        isLogin: parsedJson['isLogin'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "emailAddress": emailAddress,
      "dateOfBirth": dateOfBirth,
      "password": password,
      "gender": gender,
      "image": image,
      "isLogin": isLogin
    };
  }
}
