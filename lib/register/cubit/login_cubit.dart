import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/network/ttnflix_api_url.dart';
import 'package:ttn_flix/register/cubit/login_state.dart';
import 'package:ttn_flix/register/model/user_model.dart';
import 'package:ttn_flix/utils/encrypy.dart';
import 'package:ttn_flix/generated/l10n.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
      {Key? key, SharedPreferences? sharedPreferences, FirebaseAuth? auth})
      : _sharedPreferences = sharedPreferences ?? SL.get<SharedPreferences>(),
        _auth = auth ?? SL.get<FirebaseAuth>(),
        super(const LoginLoadedState());

  final SharedPreferences _sharedPreferences;
  final FirebaseAuth _auth;
  UserModel userLoad = UserModel();

  String getPasswordEncrypt({required String? encryptPassword}) {
    final encrypted =
        Encrypt.encrypt(TtnflixApiUrl.encryptKey, encryptPassword ?? "").base64;
    return encrypted.toString();
  }

  void loadSharedPrefs(
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
        password: getPasswordEncrypt(encryptPassword: password),
        isLogin: true,
        isOnboardingShow: true,
        timestamp: DateTime.timestamp().millisecondsSinceEpoch);
    // encode / convert object into json string
    String user = jsonEncode(user1);
    print(user);
    //save the data into sharedPreferences using key-value pairs
    _sharedPreferences.setString(S.current.userData, user);
  }

  Future<dynamic> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      emit(const LoginLoadingState());
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: getPasswordEncrypt(encryptPassword: password),
      );
      User? user = userCredential.user;
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(e.code.toUpperCase()));
    }
  }
}
