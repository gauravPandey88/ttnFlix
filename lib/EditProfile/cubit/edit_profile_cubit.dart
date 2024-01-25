import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/EditProfile/cubit/edit_profile_state.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/register/model/user_model.dart';
import 'package:ttn_flix/utils/date_util.dart';
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
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  Future<void> addImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (state is EditProfileLoadedState) {
      var currentState = state as EditProfileLoadedState;
      imagePath = image?.path;
      emit(currentState.copyWith(imagePath: image?.path));
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    dateofBirthController.text = getFormattedDate(picked.toString());
  }

  String _getPasswordErrorText() {
    final password = passwordTextController.text.trim();
    return (password.isNotEmpty && !ValidationHelper.isPasswordValid(password))
        ? 'At least 8 characters long'
        : '';
  }

  String _getConfirmPasswordErrorText() {
    final confirmPassword = confirmPasswordTextController.text.trim();
    return (confirmPassword.isNotEmpty &&
        !ValidationHelper.isPasswordValid(confirmPassword))
        ? 'At least 8 characters long'
        : '';
  }

  void onConfirmPasswordChange({required String password}) {
    if (state is EditProfileLoadedState) {
      final currentState = (state as EditProfileLoadedState);
      emit(currentState.copyWith(
          confirmpPassword: password,
          confirmPasswordErrorMessage: _getConfirmPasswordErrorText(),
          imagePath: imagePath));
    }
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
          genderType: currentState.genderTypeRadioList.elementAt(selectedIndex),
          imagePath: imagePath));
    }
  }

  void showAndHidePassword() {
    if (state is EditProfileLoadedState) {
      var currentState = state as EditProfileLoadedState;
      _passwordVisible = !_passwordVisible;
      emit(currentState.copyWith(
          isShowPassword: _passwordVisible,
          imagePath: imagePath));
    }
  }

  void showAndHideConfirmPassword() {
    if (state is EditProfileLoadedState) {
      var currentState = state as EditProfileLoadedState;
      _confirmPasswordVisible = !_confirmPasswordVisible;
      emit(currentState.copyWith(
          isShowConfrimPassword: _confirmPasswordVisible,
          imagePath: imagePath));
    }
  }

  Future<UserModel> getSavedInfo() async {
    Map<String, dynamic> userMap =
        jsonDecode(_sharedPreferences.getString('userData') ?? Map().toString());
    UserModel user = UserModel.fromJson(userMap);

    var currentState = state as EditProfileLoadedState;
    emit(currentState.copyWith(
        imagePath: user.image,
        name: user.userName,
        dateofBirth: user.dateOfBirth,
        genderType: user.gender,
        emailId: user.emailAddress,
    password: user.password));
    return user;
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
        userName:
            nameTextController.text.isEmpty ? name : nameTextController.text,
        emailAddress: email,
        dateOfBirth: dateofBirthController.text.isEmpty
            ? dateofBirth
            : dateofBirthController.text,
        image: image,
        gender: selectGender,
        password: passwordTextController.text.isEmpty ? password : passwordTextController.text,
        isLogin: true);
    // encode / convert object into json string
    String user = jsonEncode(user1);
    print(user);
    //save the data into sharedPreferences using key-value pairs
    _sharedPreferences.setString('userData', user);
  }
}
