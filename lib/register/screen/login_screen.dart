import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/register/cubit/login_cubit.dart';
import 'package:ttn_flix/register/cubit/login_state.dart';
import 'package:ttn_flix/register/cubit/register_cubit.dart';
import 'package:ttn_flix/register/cubit/register_state.dart';
import 'package:ttn_flix/register/model/user_model.dart';
import 'package:ttn_flix/register/screen/signup_screen.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
import 'package:ttn_flix/utils/app_alert.dart';
import 'package:ttn_flix/utils/show_snackbar.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences ?? SL.get<SharedPreferences>(),
        super(key: key);

  final SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..getSavedInfo(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoginLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 200.0, left: 10.0),
                      child: Text("Login",
                          style: TtnFlixTextStyle.defaultTextTheme.headlineLarge
                              ?.copyWith(color: TtnflixColors.whiteGlow)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                      child: Text("Please login to continue with your account",
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(color: Colors.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                      child: Text("Email Address",
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(color: Colors.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0),
                      child: TextField(
                        cursorColor: Colors.white,
                        controller: BlocProvider.of<LoginCubit>(context)
                            .emailTextController,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          BlocProvider.of<LoginCubit>(context)
                              .onEmailIdChange(emailId: value.trim());
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: TtnflixColors.greyColor,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: "Email",
                            hintStyle: TtnFlixTextStyle
                                .defaultTextTheme.titleMedium
                                ?.copyWith(color: Colors.grey),
                            errorText: state.emailIdErrorMessage.isNotEmpty
                                ? state.emailIdErrorMessage
                                : null,
                            errorStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onError)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                      child: Text("Password",
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(color: Colors.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0),
                      child: TextField(
                        obscureText:
                            state.isShowPassword ?? false ? false : true,
                        controller: BlocProvider.of<LoginCubit>(context)
                            .passwordTextController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          BlocProvider.of<LoginCubit>(context)
                              .onPasswordChange(password: value.trim());
                        },
                        decoration: InputDecoration(
                            filled: true,
                            labelStyle: TtnFlixTextStyle
                                .defaultTextTheme.titleMedium
                                ?.copyWith(color: Colors.white),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            fillColor: TtnflixColors.greyColor,
                            hintText: "Password",
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              child: GestureDetector(
                                  onTap: () {
                                    print(_sharedPreferences
                                        .getString('userData'));
                                    BlocProvider.of<LoginCubit>(context)
                                        .showAndHidePassword();
                                  },
                                  child: Icon(
                                    state.isShowPassword ?? false
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    size: 24,
                                    color: Colors.white,
                                  )),
                            ),
                            hintStyle: TtnFlixTextStyle
                                .defaultTextTheme.titleMedium
                                ?.copyWith(color: Colors.grey),
                            errorText: state.passwordErrorMessage.isNotEmpty
                                ? state.passwordErrorMessage
                                : null,
                            errorStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onError)),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: TtnflixColors.frozenListYellow
                                .platformBrightnessColor(context),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          // onPressed: !_isDisplayButtonEnable(
                          // currentState: state) ? () {
                          //   _onLogin(state, context);
                          // } : null,

                          onPressed: () {
                            _onLogin(state, context);
                          },

                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () => context.router.push(SignupScreenRoute()),
                        child: Text('New User? Create Account',
                            style: TtnFlixTextStyle.defaultTextTheme.titleMedium
                                ?.copyWith(
                                    color: TtnflixColors.frozenListYellow
                                        .platformBrightnessColor(context))),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  void _onLogin(LoginLoadedState state, BuildContext context) {
    Map<String, dynamic> userMap =
        jsonDecode(_sharedPreferences.getString('userData') ?? "");
    UserModel user = UserModel.fromJson(userMap);

    final cubit = BlocProvider.of<LoginCubit>(context);

    if (cubit.emailTextController.text.isEmpty &&
        cubit.passwordTextController.text.isEmpty) {
      "Please enter email and password".showSnackbar(context);
    } else if (cubit.emailTextController.text.isEmpty) {
      "Please enter email".showSnackbar(context);
    } else if (state.emailIdErrorMessage.isNotEmpty) {
      "Please enter correct email".showSnackbar(context);
    } else if (cubit.passwordTextController.text.isEmpty) {
      "Please enter password".showSnackbar(context);
    } else if (state.passwordErrorMessage.isNotEmpty) {
      "Please enter correct password".showSnackbar(context);
    } else {
      if (BlocProvider.of<LoginCubit>(context).emailTextController.text ==
              user.emailAddress &&
          BlocProvider.of<LoginCubit>(context).passwordTextController.text ==
              user.password) {
        cubit.loadSharedPrefs(
            name: state.name,
            email: state.emailId,
            password: state.password,
            dateofBirth: state.dateofBirth,
            gender: state.gender,
            image: state.image);
        context.router.push(const BottomBarNavigationRoute());
      } else {
        "Entered email and password is incorrect".showSnackbar(context);
      }
    }
  }
}
