import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/network/ttnflix_api_url.dart';
import 'package:ttn_flix/register/cubit/register_state.dart';
import 'package:ttn_flix/register/model/user_model.dart';
import 'package:ttn_flix/utils/encrypy.dart';
import 'package:ttn_flix/utils/validation_helper.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TextEditingController dateofBirthController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  RegisterCubit({Key? key, SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences ?? SL.get<SharedPreferences>(),
        super(const RegisterLoadedState());

  String? imagePath;
  String? gender = "0";
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final SharedPreferences _sharedPreferences;
  UserModel userLoad = UserModel();

  Future<void> addImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (state is RegisterLoadedState) {
      var currentState = state as RegisterLoadedState;
      imagePath = image?.path;
      emit(currentState.copyWith(
          imagePath: image?.path,
          isConfirmPasswordFieldEnable: _isConfirmPasswordFieldEnable()));
    }
  }

  void setSelectedGenderType({required int selectedIndex}) {
    if (state is RegisterLoadedState) {
      var currentState = state as RegisterLoadedState;
      gender = selectedIndex.toString();
      emit(currentState.copyWith(
          genderType: currentState.genderTypeRadioList.elementAt(selectedIndex),
          imagePath: imagePath,
          isConfirmPasswordFieldEnable: _isConfirmPasswordFieldEnable()));
    }
  }

  String _getEmailIdErrorText() {
    final emailId = emailTextController.text.trim();
    return (emailId.isNotEmpty && !ValidationHelper.isValidEmail(emailId))
        ? S.current.invalidEmail
        : '';
  }

  void onEmailIdChange({required String emailId}) {
    if (state is RegisterLoadedState) {
      final currentState = (state as RegisterLoadedState);
      emit(currentState.copyWith(
          emailId: emailId,
          emailIdErrorMessage: _getEmailIdErrorText(),
          imagePath: imagePath,
          isConfirmPasswordFieldEnable: _isConfirmPasswordFieldEnable()));
    }
  }

  String _getPasswordErrorText() {
    final password = passwordTextController.text.trim();
    return (password.isNotEmpty && !ValidationHelper.isPasswordValid(password))
        ? S.current.passwordValidation
        : '';
  }

  String _getConfirmPasswordErrorText() {
    final confirmPassword = confirmPasswordTextController.text.trim();
    return (confirmPassword.isNotEmpty &&
            !ValidationHelper.isPasswordValid(confirmPassword))
        ? S.current.passwordValidation
        : '';
  }

  void onConfirmPasswordChange({required String password}) {
    if (state is RegisterLoadedState) {
      final currentState = (state as RegisterLoadedState);
      emit(currentState.copyWith(
          confirmpPassword: password,
          confirmPasswordErrorMessage: _getConfirmPasswordErrorText(),
          imagePath: imagePath,
          isConfirmPasswordFieldEnable: _isConfirmPasswordFieldEnable()));
    }
  }

  void onPasswordChange({required String password}) {
    if (state is RegisterLoadedState) {
      final currentState = (state as RegisterLoadedState);
      emit(currentState.copyWith(
          password: password,
          passwordErrorMessage: _getPasswordErrorText(),
          imagePath: imagePath,
          isConfirmPasswordFieldEnable: _isConfirmPasswordFieldEnable()));
    }
  }

  bool _isConfirmPasswordFieldEnable() {
    return (passwordTextController.text.isEmpty);
  }

  void showAndHidePassword() {
    if (state is RegisterLoadedState) {
      var currentState = state as RegisterLoadedState;
      _passwordVisible = !_passwordVisible;
      emit(currentState.copyWith(
          isShowPassword: _passwordVisible,
          imagePath: imagePath,
          isConfirmPasswordFieldEnable: _isConfirmPasswordFieldEnable()));
    }
  }

  void showAndHideConfirmPassword() {
    if (state is RegisterLoadedState) {
      var currentState = state as RegisterLoadedState;
      _confirmPasswordVisible = !_confirmPasswordVisible;
      emit(currentState.copyWith(
          isShowConfrimPassword: _confirmPasswordVisible,
          imagePath: imagePath,
          isConfirmPasswordFieldEnable: _isConfirmPasswordFieldEnable()));
    }
  }


  Future<UserModel> getSavedInfo() async {
    Map<String, dynamic> userMap =
        jsonDecode(_sharedPreferences.getString(S.current.userData) ?? Map().toString());
    UserModel user = UserModel.fromJson(userMap);

    var currentState = state as RegisterLoadedState;
    emit(currentState.copyWith(
        emailId: user.emailAddress, password: user.password));
    return user;
  }

  String _getPasswordEncrypt() {
    final password = passwordTextController.text;
    final encrypted = Encrypt.encrypt(TtnflixApiUrl.encryptKey, password).base64;
    return encrypted.toString();
  }

  loadSharedPrefs() async {
    //  store the user entered data in user object
    UserModel user1 = UserModel(
        userName: nameTextController.text,
        emailAddress: emailTextController.text,
        dateOfBirth: dateofBirthController.text,
        image: imagePath,
        gender: gender,
        password: _getPasswordEncrypt().toString(),
        isLogin: true);
    // encode / convert object into json string
    String user = jsonEncode(user1);
    print(user);
    //save the data into sharedPreferences using key-value pairs
    _sharedPreferences.setString(S.current.userData, user);
  }

  void clearAll() {
    if (state is RegisterLoadedState) {
      dateofBirthController.clear();
      nameTextController.clear();
      emailTextController.clear();
      passwordTextController.clear();
      confirmPasswordTextController.clear();
      emit(RegisterLoadedState());
    }
  }
}
