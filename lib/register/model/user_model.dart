
import 'dart:typed_data';

class UserModel {
  late final String? userName;
  final String? emailAddress;
  final String? dateOfBirth;
  final String? password;
  final String? gender;
  final String? image;
  final bool? isLogin;
  final bool? isOnboardingShow;
  final int? timestamp;

  UserModel(
      {this.userName,
      this.emailAddress,
      this.dateOfBirth,
      this.password,
      this.image,
      this.gender,
      this.isLogin,
      this.isOnboardingShow,
      this.timestamp});

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
        userName: parsedJson['userName'] ?? "",
        emailAddress: parsedJson['emailAddress'] ?? "",
        dateOfBirth: parsedJson['dateOfBirth'] ?? "",
        password: parsedJson['password'] ?? "",
        gender: parsedJson['gender'] ?? "",
        image: parsedJson['image'] ?? "",
        timestamp: parsedJson['timestamp'],
        isLogin: parsedJson['isLogin'] ?? false,
        isOnboardingShow: parsedJson['isOnboardingShow'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "emailAddress": emailAddress,
      "dateOfBirth": dateOfBirth,
      "password": password,
      "gender": gender,
      "image": image,
      "isLogin": isLogin,
      "timestamp": timestamp,
      "isOnboardingShow": isOnboardingShow,
    };
  }
}
