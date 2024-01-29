import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/network/ttnflix_api_url.dart';
import 'package:ttn_flix/register/cubit/login_state.dart';
import 'package:ttn_flix/register/model/user_model.dart';
import 'package:ttn_flix/utils/encrypy.dart';
import 'package:ttn_flix/utils/validation_helper.dart';
import 'package:ttn_flix/generated/l10n.dart';



class LoginCubit extends Cubit<LoginState> {
  LoginCubit({Key? key, SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences ?? SL.get<SharedPreferences>(),
        super(const LoginLoadedState());

  final SharedPreferences _sharedPreferences;
  UserModel userLoad = UserModel();
  bool _passwordVisible = false;
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  Future<UserModel> getSavedInfo() async {
    Map<String, dynamic> userMap = jsonDecode(
        _sharedPreferences.getString(S.current.userData) ?? Map().toString());
    UserModel user = UserModel.fromJson(userMap);

    // final password = user.password;
    // final decrypt = Encrypt.decrypt(TtnflixApiUrl.encryptKey, password ?? "");

    var currentState = state as LoginLoadedState;
    emit(currentState.copyWith(
        emailId: user.emailAddress,
        password: getPasswordDecrypt(encryptPassword: user.password),
        image: user.image,
        gender: user.gender,
        name: user.userName,
        dateofBirth: user.dateOfBirth));
    return user;
  }

  String _getEmailIdErrorText() {
    final emailId = emailTextController.text.trim();
    return (emailId.isNotEmpty && !ValidationHelper.isValidEmail(emailId))
        ? S.current.invalidEmail
        : '';
  }

  void onEmailIdChange({required String emailId}) {
    if (state is LoginLoadedState) {
      final currentState = (state as LoginLoadedState);
      emit(currentState.copyWith(
          emailId: emailId, emailIdErrorMessage: _getEmailIdErrorText()));
    }
  }

  String _getPasswordErrorText() {
    final password = passwordTextController.text.trim();
    return (password.isNotEmpty && !ValidationHelper.isPasswordValid(password))
        ? 'At least 8 characters long'
        : '';
  }

  void onPasswordChange({required String password}) {
    if (state is LoginLoadedState) {
      final currentState = (state as LoginLoadedState);
      emit(currentState.copyWith(
          password: password, passwordErrorMessage: _getPasswordErrorText()));
    }
  }

  void showAndHidePassword() {
    if (state is LoginLoadedState) {
      var currentState = state as LoginLoadedState;
      _passwordVisible = !_passwordVisible;
      emit(currentState.copyWith(isShowPassword: _passwordVisible));
    }
  }

  bool isDisplayButtonEnable() {
    if (state is LoginLoadedState) {
      (emailTextController.text.isNotEmpty ||
          passwordTextController.text.isNotEmpty);
      return true;
    } else {
      return false;
    }
  }

  String getPasswordDecrypt({required String? encryptPassword}) {
    final password = encryptPassword;
    final decrypt = Encrypt.decrypt(TtnflixApiUrl.encryptKey, password ?? "");
    return decrypt.toString();
  }

  String getPasswordEncrypt({required String? encryptPassword}) {
    final encrypted = Encrypt.encrypt(TtnflixApiUrl.encryptKey, encryptPassword ?? "").base64;
    return encrypted.toString();
  }

  loadSharedPrefs(
      {String? image,
      String? name,
      String? dateofBirth,
      String? email,
      String? gender,
      String? password}) async {
    //  store the user entered data in user object
    UserModel user1 = UserModel(
        userName: name,
        emailAddress: email,
        dateOfBirth: dateofBirth,
        image: image,
        gender: gender,
        password: password,
        isLogin: true);
    // encode / convert object into json string
    String user = jsonEncode(user1);
    print(user);
    //save the data into sharedPreferences using key-value pairs
    _sharedPreferences.setString(S.current.userData, user);
  }
}
