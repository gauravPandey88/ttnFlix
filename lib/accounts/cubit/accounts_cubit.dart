import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/accounts/cubit/accounts_state.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/register/model/user_model.dart';

class AccountsCubit extends Cubit<AccountsState> {
  AccountsCubit({Key? key, SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences ?? SL.get<SharedPreferences>(),
        super(const AccountLoadedState());

  UserModel userLoad = UserModel();
  final SharedPreferences _sharedPreferences;

  Future<UserModel> getSavedInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(
        preferences.getString(S.current.userData) ?? Map().toString());
    UserModel user = UserModel.fromJson(userMap);

    var currentState = state as AccountLoadedState;
    emit(currentState.copyWith(
      name: user.userName,
      emailAddress: user.emailAddress,
      image: user.image,
      gender: user.gender,
      password: user.password,
      dateOfBirth: user.dateOfBirth,
      timeStamp: user.timestamp
    ));
    return user;
  }

  loadSharedPrefs(
      {String? image,
      String? name,
      String? dateofBirth,
      String? email,
      String? gender,
      String? password,
      int? timeStamp,
      bool? isLogin}) async {
    //  store the user entered data in user object
    UserModel user1 = UserModel(
        userName: name,
        emailAddress: email,
        dateOfBirth: dateofBirth,
        image: image,
        gender: gender,
        password: password,
        timestamp: timeStamp,
        isOnboardingShow: true,
        isLogin: isLogin);
    // encode / convert object into json string
    String user = jsonEncode(user1);
    print(user);
    //save the data into sharedPreferences using key-value pairs
    _sharedPreferences.setString(S.current.userData, user);
  }
}
