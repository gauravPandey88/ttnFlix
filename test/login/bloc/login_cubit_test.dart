import 'dart:async';
import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/register/cubit/login_cubit.dart';
import 'package:ttn_flix/register/cubit/login_state.dart';
import 'package:ttn_flix/register/model/user_model.dart';

import 'login_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SharedPreferences>(),
  MockSpec<FirebaseAuth>(),
  MockSpec<UserCredential>(),
  MockSpec<User>(),
  MockSpec<UserModel>()
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SharedPreferences sharedPreferences;
  late LoginCubit cubit;
  late FirebaseAuth firebaseAuth;
  late UserCredential userCredential;
  late User mockUser;
  late UserModel mockUserModel;

  setUpAll(() async {
    await S.load(const Locale('en'));
    sharedPreferences = MockSharedPreferences();
    final serviceLocator = ServiceLocator.ttnflixServiceLocator;
    serviceLocator.registerSingleton<SharedPreferences>(sharedPreferences);

    when(sharedPreferences.getString(S.current.userData)).thenReturn('');


    // cubit = MockLoginCubit();

  });

  setUp(() async {
    firebaseAuth = MockFirebaseAuth();
    userCredential = MockUserCredential();
    mockUser = MockUser();
    cubit = LoginCubit(auth: firebaseAuth);

  });



  blocTest<LoginCubit, LoginState>(
    'Test for singing with email and password handle  success state',
    build: () {
      return cubit;
    },
    act: (cubit) {
      when(firebaseAuth.signInWithEmailAndPassword(
              email: 'abc@gmail.com',
              password: cubit.getPasswordEncrypt(encryptPassword: '123456789')))
          .thenAnswer((_) => Future.value(userCredential));
      when(userCredential.user).thenAnswer((_) => mockUser);
      return cubit.signInUsingEmailPassword(
          email: 'abc@gmail.com', password: '123456789');
    },

    // expect: () => [isA<LoginLoadingState>(), isA<LoginSuccessState>()],

    verify: (cubit) {
      expect((cubit.state), LoginSuccessState());
    },
  );

  // blocTest<LoginCubit, LoginState>(
  //   'Test for singing with email and password handle error state',
  //   build: () {
  //     when(firebaseAuth.signInWithEmailAndPassword(
  //         email: 'abc@gmail.com',
  //         password: cubit.getPasswordEncrypt(encryptPassword: '123456789')))
  //         .thenThrow((_) => Future.value(FirebaseAuthException));
  //     return cubit;
  //   },
  //   act: (cubit) {
  //
  //    // when(userCredential.user).thenAnswer((_) => mockUser);
  //     return cubit.signInUsingEmailPassword(
  //         email: 'abc@gmail.com', password: '123456789');
  //   },
  //   verify: (cubit) {
  //     expect((cubit.state), const LoginErrorState(''));
  //   },
  // );

  // blocTest<LoginCubit, LoginState>(
  //   'Test for load prefs',
  //   build: () {
  //     return cubit;
  //   },
  //
  //   verify: (cubit) {
  //
  //     verify(
  //         cubit.loadSharedPrefs()
  //     ).called(1);
  //
  //   },
  // );
}

