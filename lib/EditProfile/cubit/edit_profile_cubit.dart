import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/EditProfile/cubit/edit_profile_state.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/network/ttnflix_api_url.dart';
import 'package:ttn_flix/register/model/user_model.dart';
import 'package:ttn_flix/utils/encrypy.dart';
import 'package:ttn_flix/utils/validation_helper.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final TextEditingController dateofBirthController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  EditProfileCubit({Key? key, SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences ?? SL.get<SharedPreferences>(),
        super(const EditProfileLoadedState());

  final SharedPreferences _sharedPreferences;
  UserModel userLoad = UserModel();
  String? imagePath;
  String? selectGender;
  int? timeStamp;
  bool _passwordVisible = false;

  Future<void> addImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (state is EditProfileLoadedState) {
      var currentState = state as EditProfileLoadedState;
      imagePath = image?.path;
      emit(currentState.copyWith(
          imagePath: image?.path, genderType: selectGender));
    }
  }

  String _getPasswordErrorText() {
    final password = passwordTextController.text.trim();
    return (password.isNotEmpty && !ValidationHelper.isPasswordValid(password))
        ? S.current.passwordValidation
        : '';
  }

  void onPasswordChange({required String password}) {
    if (state is EditProfileLoadedState) {
      final currentState = (state as EditProfileLoadedState);
      emit(currentState.copyWith(
          password: password,
          passwordErrorMessage: _getPasswordErrorText(),
          imagePath: imagePath));
    }
  }

  void setSelectedGenderType({required int selectedIndex}) {
    if (state is EditProfileLoadedState) {
      var currentState = state as EditProfileLoadedState;
      selectGender = selectedIndex.toString();
      emit(currentState.copyWith(
          genderType: selectGender, imagePath: imagePath, timeStamp: timeStamp));
    }
  }

  void showAndHidePassword() {
    if (state is EditProfileLoadedState) {
      var currentState = state as EditProfileLoadedState;
      _passwordVisible = !_passwordVisible;
      emit(currentState.copyWith(
          isShowPassword: _passwordVisible, imagePath: imagePath));
    }
  }

  String getPasswordEncrypt({required String? encryptPassword}) {
    final password = passwordTextController.text.isEmpty
        ? encryptPassword
        : passwordTextController.text;
    final encrypted =
        Encrypt.encrypt(TtnflixApiUrl.encryptKey, password ?? "").base64;
    return encrypted.toString();
  }

  String getPasswordDecrypt({required String? encryptPassword}) {
    final password = encryptPassword;
    final decrypt = Encrypt.decrypt(TtnflixApiUrl.encryptKey, password ?? "");
    return decrypt.toString();
  }

  Future<UserModel> getSavedInfo() async {
    Map<String, dynamic> userMap = jsonDecode(
        _sharedPreferences.getString(S.current.userData) ?? {}.toString());
    UserModel user = UserModel.fromJson(userMap);
    nameTextController.text = user.userName ?? "";
    passwordTextController.text =
        getPasswordDecrypt(encryptPassword: user.password);
    dateofBirthController.text = user.dateOfBirth ?? "";
    selectGender = user.gender;
    timeStamp = user.timestamp;
    var currentState = state as EditProfileLoadedState;
    emit(currentState.copyWith(
        imagePath: user.image,
        name: user.userName,
        dateofBirth: user.dateOfBirth,
        genderType: user.gender,
        emailId: user.emailAddress,
        password: getPasswordDecrypt(encryptPassword: user.password),
        timeStamp: user.timestamp));
    return user;
  }

  loadSharedPrefs(
      {String? image,
      String? name,
      String? dateOfBirth,
      String? email,
      String? gender,
      String? password}) async {
    //  store the user entered data in user object
    UserModel user1 = UserModel(
        userName:
            nameTextController.text.isEmpty ? name : nameTextController.text,
        emailAddress: email,
        dateOfBirth: dateofBirthController.text.isEmpty
            ? dateOfBirth
            : dateofBirthController.text,
        image: image,
        gender: selectGender,
        password: getPasswordEncrypt(encryptPassword: password),
        isLogin: true,
        isOnboardingShow: true,
        timestamp: timeStamp);
    // encode / convert object into json string

    String user = jsonEncode(user1);
    print(user);
    //save the data into sharedPreferences using key-value pairs
    _sharedPreferences.setString(S.current.userData, user);
  }
}
