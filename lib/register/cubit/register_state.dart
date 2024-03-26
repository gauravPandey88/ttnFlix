import 'dart:io';
import 'dart:typed_data';

import 'package:ttn_flix/utils/default_equatable.dart';

class GenderStateConstants {
  static const List<String> genderTypeRadioList = ['Male', 'Female', 'other'];
}

abstract class RegisterState  extends DefaultEquatable{
  const RegisterState();
}

class ImageLoadedState extends RegisterState {
  final String? imagePath;

  const ImageLoadedState( {
    this.imagePath,
});

  ImageLoadedState copyWith({
    final String? imagePath,
  }) {
    return ImageLoadedState(
        imagePath : imagePath ?? this.imagePath);
  }

  @override
  List<Object?> get props => [imagePath];
}

class RegisterLoadedState extends RegisterState {
  final String? name;
  final String? imagePath;
  final List<String> genderTypeRadioList;
  final int initialSelectedGenderTypeIndex;
  final String? genderType;
  final String password;
  final String? confirmPassword;
  final String passwordErrorMessage;
  final bool? isShowPassword;
  final bool? isShowConfrimPassword;
  final String emailId;
  final String emailIdErrorMessage;
  final String confirmPasswordErrorMessage;
  final String? message;

  const RegisterLoadedState(
      {this.name,
      this.message,
      this.imagePath,
      this.genderTypeRadioList = GenderStateConstants.genderTypeRadioList,
      this.initialSelectedGenderTypeIndex = 0,
      this.genderType,
      this.isShowPassword,
      this.isShowConfrimPassword,
      this.password = '',
      this.confirmPassword = '',
      this.emailId = '',
      this.emailIdErrorMessage = '',
      this.passwordErrorMessage = '',
      this.confirmPasswordErrorMessage = ''});

  RegisterLoadedState copyWith(
      {final String? imagePath,
      String? genderType,
      final String? name,
      List<String>? genderTypeRadioList,
      final int? initialSelectedAuditTypeIndex,
      final bool? isShowPassword,
      final bool? isShowConfrimPassword,
      String? password,
      String? confirmpPassword,
      String? emailId,
      String? emailIdErrorMessage,
      String? passwordErrorMessage,
      String? message,
      String? confirmPasswordErrorMessage}) {
    return RegisterLoadedState(
        message: message ?? this.message,
        name: name ?? this.name,
        imagePath: imagePath ?? this.imagePath,
        genderTypeRadioList: genderTypeRadioList ?? this.genderTypeRadioList,
        genderType: genderType ?? this.genderType,
        emailId: emailId ?? this.emailId,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? confirmPassword,
        initialSelectedGenderTypeIndex:
            initialSelectedAuditTypeIndex ?? initialSelectedGenderTypeIndex,
        isShowPassword: isShowPassword ?? this.isShowPassword,
        isShowConfrimPassword:
            isShowConfrimPassword ?? this.isShowConfrimPassword,
        emailIdErrorMessage: emailIdErrorMessage ?? this.emailIdErrorMessage,
        passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
        confirmPasswordErrorMessage:
            confirmPasswordErrorMessage ?? this.confirmPasswordErrorMessage);
  }

  @override
  List<Object?> get props => [
        message,
        name,
        imagePath,
        genderTypeRadioList,
        genderType,
        initialSelectedGenderTypeIndex,
        isShowPassword,
        isShowConfrimPassword,
        password,
        confirmPassword,
        emailId,
        emailIdErrorMessage,
        confirmPasswordErrorMessage,
      ];
}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String? message;
  const RegisterErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
