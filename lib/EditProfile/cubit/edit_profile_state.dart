import 'package:ttn_flix/utils/default_equatable.dart';

class GenderStateConstants {
  static const List<String> genderTypeRadioList = [
    'Male',
    'Female',
    'Other'
  ];
}

abstract class EditProfileState extends DefaultEquatable {
  const EditProfileState();
}

class EditProfileLoadedState extends EditProfileState {
  final String? name;
  final String? emailId;
  final String? imagePath;
  final String passwordErrorMessage;
  final String confirmPasswordErrorMessage;
  final String password;
  final String? confirmPassword;
  final bool? isShowPassword;
  final bool? isShowConfrimPassword;
  final String? genderType;
  final String? dateofBirth;
  final List<String> genderTypeRadioList;
  final int initialSelectedGenderTypeIndex;

  const EditProfileLoadedState({
    this.name,
    this.emailId,
    this.password = '',
    this.confirmPassword = '',
    this.imagePath,
    this.isShowPassword,
    this.isShowConfrimPassword,
    this.dateofBirth,
    this.genderType,
    this.passwordErrorMessage = '',
    this.confirmPasswordErrorMessage = '',
    this.genderTypeRadioList = GenderStateConstants.genderTypeRadioList,
    this.initialSelectedGenderTypeIndex = 0,
  });

  EditProfileLoadedState copyWith({
    final String? imagePath = "",
    final String? name,
    String? password,
    String? confirmpPassword,
    final bool? isShowPassword,
    final bool? isShowConfrimPassword,
    String? passwordErrorMessage,
    String? confirmPasswordErrorMessage,
    final String? emailId,
    final String? dateofBirth,
    final String? genderType,
    List<String>? genderTypeRadioList,
    final int? initialSelectedAuditTypeIndex,
  }) {
    return EditProfileLoadedState(
      name: name ?? this.name,
      emailId: emailId ?? this.emailId,
      password: password ?? this.password,
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      confirmPasswordErrorMessage:
      confirmPasswordErrorMessage ?? this.confirmPasswordErrorMessage,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isShowConfrimPassword:
      isShowConfrimPassword ?? this.isShowConfrimPassword,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      imagePath: imagePath ?? this.imagePath,
      dateofBirth: dateofBirth ?? this.dateofBirth,
      genderType: genderType ?? this.genderType,
      genderTypeRadioList: genderTypeRadioList ?? this.genderTypeRadioList,
      initialSelectedGenderTypeIndex: initialSelectedAuditTypeIndex ??
          this.initialSelectedGenderTypeIndex,
    );
  }

  @override
  List<Object?> get props => [
    name,
    emailId,
    password,
    confirmPassword,
    isShowPassword,
    isShowConfrimPassword,
    passwordErrorMessage,
    confirmPasswordErrorMessage,
    imagePath,
    dateofBirth,
    genderType,
    genderTypeRadioList,
    initialSelectedGenderTypeIndex,
    ];
}
