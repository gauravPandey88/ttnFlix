import 'package:ttn_flix/utils/default_equatable.dart';

abstract class LoginState extends DefaultEquatable {
  const LoginState();
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

class LoginLoadedState extends LoginState {
  final String emailId;
  final String password;
  final String? image;
  final String? dateOfBirth;
  final String? gender;
  final String? name;
  final String emailIdErrorMessage;
  final String passwordErrorMessage;
  final bool? isShowPassword;
  final bool? isDisable;
  final String? timeStamp;

  const LoginLoadedState(
      {this.isShowPassword,
      this.image,
      this.dateOfBirth,
      this.name,
      this.gender,
      this.password = '',
      this.emailId = '',
      this.emailIdErrorMessage = '',
      this.passwordErrorMessage = '',
      this.timeStamp,
      this.isDisable});

  LoginLoadedState copyWith({
    final bool? isShowPassword,
    final String? dateOfBirth,
    final String? timeStamp,
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
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        timeStamp: timeStamp ?? this.timeStamp,
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
        dateOfBirth,
        name,
        isShowPassword,
        image,
        gender,
        password,
        emailId,
        emailIdErrorMessage,
        isDisable,
        timeStamp
      ];
}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String? message;
  const LoginErrorState(this.message);

  @override
  List<Object?> get props => [
    message
  ];
}
