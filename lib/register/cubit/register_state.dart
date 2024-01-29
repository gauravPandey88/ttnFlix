import 'package:ttn_flix/home/model/ttnflix_movies.dart';
import 'package:ttn_flix/utils/default_equatable.dart';

class GenderStateConstants {
  static const List<String> genderTypeRadioList = [
    'Male',
    'Female',
    'other'
  ];
}

abstract class RegisterState extends DefaultEquatable {
  const RegisterState();
}

// class RegisterLoadingState extends RegisterState {
//   const RegisterLoadingState();
// }

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
  final bool? isConfirmPasswordFieldEnable;

  const RegisterLoadedState(
      {this.name,
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
      this.confirmPasswordErrorMessage = '',
      this.isConfirmPasswordFieldEnable});

  RegisterLoadedState copyWith(
      {final String? imagePath = "",
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
      String? confirmPasswordErrorMessage,
        bool? isConfirmPasswordFieldEnable,}) {
    return RegisterLoadedState(
        name: name ?? this.name,
        imagePath: imagePath ?? this.imagePath,
        genderTypeRadioList: genderTypeRadioList ?? this.genderTypeRadioList,
        genderType: genderType ?? this.genderType,
        emailId: emailId ?? this.emailId,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        initialSelectedGenderTypeIndex: initialSelectedAuditTypeIndex ??
            this.initialSelectedGenderTypeIndex,
        isShowPassword: isShowPassword ?? this.isShowPassword,
        isShowConfrimPassword:
            isShowConfrimPassword ?? this.isShowConfrimPassword,
        emailIdErrorMessage: emailIdErrorMessage ?? this.emailIdErrorMessage,
        passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
        confirmPasswordErrorMessage:
            confirmPasswordErrorMessage ?? this.confirmPasswordErrorMessage,
    isConfirmPasswordFieldEnable: isConfirmPasswordFieldEnable ?? this.isConfirmPasswordFieldEnable);
  }

  @override
  List<Object?> get props => [
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
    isConfirmPasswordFieldEnable
      ];
}
