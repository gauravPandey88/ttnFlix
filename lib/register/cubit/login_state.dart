import 'package:ttn_flix/utils/default_equatable.dart';

abstract class LoginState extends DefaultEquatable {
  const LoginState();
}

class LoginLoadedState extends LoginState {
  final String emailId;
  final String password;
  final String? image;
  final String? dateofBirth;
  final String? gender;
  final String? name;
  final String emailIdErrorMessage;
  final String passwordErrorMessage;
  final bool? isShowPassword;
  final bool? isDisable;

  const LoginLoadedState(
      {this.isShowPassword,
      this.image,
      this.dateofBirth,
      this.name,
      this.gender,
      this.password = '',
      this.emailId = '',
      this.emailIdErrorMessage = '',
      this.passwordErrorMessage = '',
      this.isDisable});

  LoginLoadedState copyWith({
    final bool? isShowPassword,
    final String? dateofBirth,
    String? password,
    String? image,
    final String? name,
    String? gender,
    String? emailId,
    String? emailIdErrorMessage,
    String? passwordErrorMessage,
    final bool? isDisable,
  }) {
    return LoginLoadedState(
        dateofBirth: dateofBirth ?? this.dateofBirth,
        name: name ?? this.name,
        image: image ?? this.image,
        gender: gender ?? this.gender,
        emailId: emailId ?? this.emailId,
        password: password ?? this.password,
        isShowPassword: isShowPassword ?? this.isShowPassword,
        emailIdErrorMessage: emailIdErrorMessage ?? this.emailIdErrorMessage,
        passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
        isDisable: isDisable ?? this.isDisable);
  }

  @override
  List<Object?> get props => [
        dateofBirth,
        name,
        isShowPassword,
        image,
        gender,
        password,
        emailId,
        emailIdErrorMessage,
        isDisable
      ];
}
