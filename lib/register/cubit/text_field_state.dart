import 'package:ttn_flix/utils/default_equatable.dart';

class GenderStateConstants {
  static const List<String> genderTypeRadioList = ['Male', 'Female', 'other'];
}

abstract class TextFieldState extends DefaultEquatable {
  const TextFieldState();
}

class TextFieldLoadingState extends TextFieldState {
  final String emailIdErrorMessage;
  final String passwordErrorMessage;
  final bool? isShowPassword;
  final bool? isShowConfrimPassword;
  final List<String> genderTypeRadioList;
  final int initialSelectedGenderTypeIndex;

  const TextFieldLoadingState(
      {this.genderTypeRadioList = GenderStateConstants.genderTypeRadioList,
      this.initialSelectedGenderTypeIndex = 0,
      this.isShowPassword,
      this.emailIdErrorMessage = '',
      this.passwordErrorMessage = '',
      this.isShowConfrimPassword});

  TextFieldLoadingState copyWith({
    List<String>? genderTypeRadioList,
    final int? initialSelectedAuditTypeIndex,
    final bool? isShowPassword,
    final bool? isShowConfrimPassword,
    final String? emailIdErrorMessage,
    final String? passwordErrorMessage,
  }) {
    return TextFieldLoadingState(
        genderTypeRadioList: genderTypeRadioList ?? this.genderTypeRadioList,
        initialSelectedGenderTypeIndex:
            initialSelectedAuditTypeIndex ?? initialSelectedGenderTypeIndex,
        isShowConfrimPassword:
            isShowConfrimPassword ?? this.isShowConfrimPassword,
        isShowPassword: isShowPassword ?? this.isShowPassword,
        emailIdErrorMessage: emailIdErrorMessage ?? this.emailIdErrorMessage,
        passwordErrorMessage:
            passwordErrorMessage ?? this.passwordErrorMessage);
  }

  @override
  List<Object?> get props => [
        isShowPassword,
        emailIdErrorMessage,
        passwordErrorMessage,
        isShowConfrimPassword,
        genderTypeRadioList,
        initialSelectedGenderTypeIndex
      ];
}
