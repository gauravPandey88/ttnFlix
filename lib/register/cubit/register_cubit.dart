import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:file_picker/file_picker.dart';

class RegisterCubit extends Cubit<RegisterState> {

  RegisterCubit({Key? key, SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences ?? SL.get<SharedPreferences>(),
        super(const ImageLoadedState());

  Uint8List? selectedImageInBytes;
  String? imagePath;
  File? selectedImage;
  String? _image;
  String? gender = "0";
  final SharedPreferences _sharedPreferences;
  UserModel userLoad = UserModel();

  void addImage() async {
    XFile? returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    var imageBytes = await returnImage.readAsBytes();
      selectedImage = File(returnImage.path);
    String s = String.fromCharCodes(imageBytes);
      _image = s;
     imagePath = _image;

     emit(const ImageLoadedState().copyWith(imagePath: _image));
  }

  void setSelectedGenderType({required int selectedIndex}) {
    if (state is RegisterLoadedState) {
      var currentState = state as RegisterLoadedState;
      gender = selectedIndex.toString();
      emit(currentState.copyWith(
          genderType: currentState.genderTypeRadioList.elementAt(selectedIndex),
          imagePath: _image));
    }
  }

  String getPasswordEncrypt({required String? encryptPassword}) {
    final encrypted =
        Encrypt.encrypt(TtnflixApiUrl.encryptKey, encryptPassword ?? "").base64;
    return encrypted.toString();
  }

  loadSharedPrefs({
    required String name,
    required String dob,
    required String email,
    required String password,
  }) async {
    //  store the user entered data in user object
    UserModel user1 = UserModel(
        userName: name,
        emailAddress: email,
        dateOfBirth: dob,
        image: imagePath,
        gender: gender,
        password: password,
        isLogin: true,
        isOnboardingShow: true,
        timestamp: DateTime.now().millisecondsSinceEpoch);
    // encode / convert object into json string
    String user = jsonEncode(user1);
    print(user);
    //save the data into sharedPreferences using key-value pairs
    _sharedPreferences.setString(S.current.userData, user);
  }

  void registerUsingEmailPassword(
      {required String name, required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      emit(const RegisterLoadedState());
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(RegisterErrorState(e.code));
    }
  }
}
