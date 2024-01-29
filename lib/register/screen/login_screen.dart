import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/register/cubit/login_cubit.dart';
import 'package:ttn_flix/register/cubit/login_state.dart';
import 'package:ttn_flix/register/model/user_model.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
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
        backgroundColor: TtnflixColors.textBlackColor.platformBrightnessColor(context),
        body: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoginLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: TtnflixSpacing.spacing200,
                          left: TtnflixSpacing.spacing10),
                      child: Text(S.of(context).login,
                          style: TtnFlixTextStyle.defaultTextTheme.headlineLarge
                              ?.copyWith(color: TtnflixColors.whiteGlow)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: TtnflixSpacing.spacing10,
                          left: TtnflixSpacing.spacing10),
                      child: Text(S.of(context).loginTitle,
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(color: TtnflixColors.cellTextColor.platformBrightnessColor(context))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: TtnflixSpacing.spacing20,
                          left: TtnflixSpacing.spacing10),
                      child: Text(S.of(context).emailAddress,
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(color: TtnflixColors.cellTextColor.platformBrightnessColor(context))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: TtnflixSpacing.spacing10,
                          left: TtnflixSpacing.spacing10,
                          right: TtnflixSpacing.spacing10),
                      child: TextField(
                        cursorColor: TtnflixColors.whiteGlow,
                        controller: BlocProvider.of<LoginCubit>(context)
                            .emailTextController,
                        style: const TextStyle(color: TtnflixColors.whiteGlow),
                        onChanged: (value) {
                          BlocProvider.of<LoginCubit>(context)
                              .onEmailIdChange(emailId: value.trim());
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: TtnflixColors.greyColor,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: TtnflixColors.whiteGlow),
                            ),
                            hintText: S.of(context).email,
                            hintStyle: TtnFlixTextStyle
                                .defaultTextTheme.titleMedium
                                ?.copyWith(color: TtnflixColors.cellTextColor.platformBrightnessColor(context)),
                            errorText: state.emailIdErrorMessage.isNotEmpty
                                ? state.emailIdErrorMessage
                                : null,
                            errorStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onError)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: TtnflixSpacing.spacing20,
                          left: TtnflixSpacing.spacing10),
                      child: Text(S.of(context).password,
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(color: TtnflixColors.cellTextColor.platformBrightnessColor(context))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: TtnflixSpacing.spacing10,
                          left: TtnflixSpacing.spacing10,
                          right: TtnflixSpacing.spacing10),
                      child: TextField(
                        obscureText:
                            state.isShowPassword ?? false ? false : true,
                        controller: BlocProvider.of<LoginCubit>(context)
                            .passwordTextController,
                        cursorColor: TtnflixColors.whiteGlow,
                        style: const TextStyle(color: TtnflixColors.whiteGlow),
                        onChanged: (value) {
                          BlocProvider.of<LoginCubit>(context)
                              .onPasswordChange(password: value.trim());
                        },
                        decoration: InputDecoration(
                            filled: true,
                            labelStyle: TtnFlixTextStyle
                                .defaultTextTheme.titleMedium
                                ?.copyWith(color: TtnflixColors.whiteGlow),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: TtnflixColors.whiteGlow),
                            ),
                            fillColor: TtnflixColors.greyColor,
                            hintText: S.of(context).password,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  TtnflixSpacing.spacing0,
                                  TtnflixSpacing.spacing0,
                                  TtnflixSpacing.spacing4,
                                  TtnflixSpacing.spacing0),
                              child: GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<LoginCubit>(context)
                                        .showAndHidePassword();
                                  },
                                  child: Icon(
                                    state.isShowPassword ?? false
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    size: TtnflixSpacing.spacing24,
                                    color: TtnflixColors.whiteGlow,
                                  )),
                            ),
                            hintStyle: TtnFlixTextStyle
                                .defaultTextTheme.titleMedium
                                ?.copyWith(color: TtnflixColors.cellTextColor.platformBrightnessColor(context)),
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
                        height: TtnflixSpacing.spacing50,
                        width: TtnflixSpacing.spacing250,
                        decoration: BoxDecoration(
                            color: TtnflixColors.frozenListYellow
                                .platformBrightnessColor(context),
                            borderRadius: BorderRadius.circular(
                                TtnflixSpacing.spacing20)),
                        child: TextButton(
                          onPressed: () {
                            _onLogin(state, context);
                          },
                          child: Text(
                            S.of(context).login,
                            style: TextStyle(
                                color: TtnflixColors.textBlackColor.platformBrightnessColor(context),
                                fontSize: TtnflixSpacing.spacing25),
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
                        child: Text(S.of(context).newUser,
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
    Map<String, dynamic> userMap = jsonDecode(
        _sharedPreferences.getString(S.of(context).userData) ??
            Map().toString());
    UserModel user = UserModel.fromJson(userMap);

    final cubit = BlocProvider.of<LoginCubit>(context);

    if (cubit.emailTextController.text.isEmpty &&
        cubit.passwordTextController.text.isEmpty) {
      S.of(context).enterEmailAndPassword.showSnackbar(context);
    } else if (cubit.emailTextController.text.isEmpty) {
      S.of(context).enterEmail.showSnackbar(context);
    } else if (state.emailIdErrorMessage.isNotEmpty) {
      S.of(context).enterCorrectEmail.showSnackbar(context);
    } else if (cubit.passwordTextController.text.isEmpty) {
      S.of(context).enterPassword.showSnackbar(context);
    } else if (state.passwordErrorMessage.isNotEmpty) {
      S.of(context).enterCorrectPassword.showSnackbar(context);
    } else {
      if (cubit.emailTextController.text == user.emailAddress &&
          cubit.passwordTextController.text == cubit.getPasswordDecrypt(encryptPassword: user.password)) {
        cubit.loadSharedPrefs(
            name: state.name,
            email: state.emailId,
            password: cubit.getPasswordEncrypt(encryptPassword: state.password),
            dateofBirth: state.dateofBirth,
            gender: state.gender,
            image: state.image);
        context.router.push(const BottomBarNavigationRoute());
      } else {
        S.of(context).enterEmailAndPasswordIncorrect.showSnackbar(context);
      }
    }
  }
}
