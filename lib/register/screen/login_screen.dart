import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/register/cubit/login_cubit.dart';
import 'package:ttn_flix/register/cubit/login_state.dart';
import 'package:ttn_flix/register/cubit/text_field_cubit.dart';
import 'package:ttn_flix/register/cubit/text_field_state.dart';
import 'package:ttn_flix/register/model/user_model.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
import 'package:ttn_flix/utils/context_extension.dart';
import 'package:ttn_flix/utils/show_laoder.dart';
import 'package:ttn_flix/utils/show_snackbar.dart';
import 'package:ttn_flix/utils/validator.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences ?? SL.get<SharedPreferences>(),
        super(key: key);

  final SharedPreferences _sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor:
            TtnflixColors.textBlackColor.platformBrightnessColor(context),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              Navigator.of(context).pop();
              state.message?.showSnackbar(context);
            } else if (state is LoginSuccessState) {
              Navigator.of(context).pop();
              Map<String, dynamic> userMap = jsonDecode(
                  _sharedPreferences.getString(S.of(context).userData) ??
                      {}.toString());
              UserModel user = UserModel.fromJson(userMap);
              final cubit = BlocProvider.of<LoginCubit>(context);
              cubit.loadSharedPrefs(
                  name: user.userName,
                  email: emailTextController.text,
                  password: passwordTextController.text,
                  dateofBirth: user.dateOfBirth,
                  gender: user.gender,
                  image: user.image);
              context.router.push(const BottomBarNavigationRoute());
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: SizedBox(
                      width: context.isSmallScreen ? context.width : context.width/2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: TtnflixSpacing.spacing100,
                                left: TtnflixSpacing.spacing10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(S.of(context).login,
                                  style: TtnFlixTextStyle.defaultTextTheme.headlineLarge
                                      ?.copyWith(
                                          color: TtnflixColors.titleColor
                                              .platformBrightnessColor(context))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: TtnflixSpacing.spacing10,
                                left: TtnflixSpacing.spacing10),
                            child: Align(
                             // alignment: context.isSmallScreen ? Alignment.centerLeft : Alignment.center,
                              alignment: Alignment.centerLeft,
                              child: Text(S.of(context).loginTitle,
                                  style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                                      ?.copyWith(
                                          color: TtnflixColors.titleColor
                                              .platformBrightnessColor(context))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: TtnflixSpacing.spacing20,
                                left: TtnflixSpacing.spacing10),
                            child: Text(S.of(context).emailAddress,
                                style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                                    ?.copyWith(
                                        color: TtnflixColors.titleColor
                                            .platformBrightnessColor(context))),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: TtnflixSpacing.spacing10,
                                  left: TtnflixSpacing.spacing10,
                                  right: TtnflixSpacing.spacing10),
                              child: Center(
                                child: SizedBox(
                                  width:  context.width/1,
                                  child: TextFormField(
                                    cursorColor: TtnflixColors.titleColor
                                        .platformBrightnessColor(context),
                                    controller: emailTextController,
                                    validator: (value) =>
                                        Validator.validateEmail(email: value ?? ''),
                                    style: TextStyle(
                                        color: TtnflixColors.titleColor
                                            .platformBrightnessColor(context)),
                                    decoration: buildInputDecoration(
                                        context: context,
                                        hintText: S.of(context).email,
                                        isSuffixIcon: false),
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: TtnflixSpacing.spacing20,
                                left: TtnflixSpacing.spacing10),
                            child: Text(S.of(context).password,
                                style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                                    ?.copyWith(
                                        color: TtnflixColors.titleColor
                                            .platformBrightnessColor(context))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: TtnflixSpacing.spacing10,
                                left: TtnflixSpacing.spacing10,
                                right: TtnflixSpacing.spacing10),
                            child: BlocProvider(
                              create: (context) => TextFieldCubit(),
                              child: BlocBuilder<TextFieldCubit, TextFieldState>(
                                builder: (context, state) {
                                  if (state is TextFieldLoadingState) {
                                    return TextFormField(
                                      obscureText: state.isShowPassword ?? false
                                          ? false
                                          : true,
                                      controller: passwordTextController,
                                      cursorColor: TtnflixColors.titleColor
                                          .platformBrightnessColor(context),
                                      style: TextStyle(
                                          color: TtnflixColors.titleColor
                                              .platformBrightnessColor(context)),
                                      validator: (value) =>
                                          Validator.validatePassword(
                                              password: value ?? ''),
                                      decoration: buildInputDecoration(
                                          context: context,
                                          state: state,
                                          hintText: S.of(context).password,
                                          errorText: state.passwordErrorMessage,
                                          isSuffixIcon: true),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: TtnflixSpacing.spacing50,
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
                                  if (_formKey.currentState!.validate()) {
                                    _onLogin(context: context);
                                  }
                                },
                                child: Text(
                                  S.of(context).login,
                                  style: TextStyle(
                                      color: TtnflixColors.textBlackColor
                                          .platformBrightnessColor(context),
                                      fontSize: TtnflixSpacing.spacing25),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: TtnflixSpacing.spacing100,
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
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(
      {required BuildContext context,
      TextFieldLoadingState? state,
      required String hintText,
      String? errorText,
      bool isSuffixIcon = false}) {
    return InputDecoration(
        filled: true,
        fillColor: TtnflixColors.inputBoxColor.platformBrightnessColor(context),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  TtnflixColors.titleColor.platformBrightnessColor(context)!),
        ),
        hintText: hintText,
        hintStyle: TtnFlixTextStyle.defaultTextTheme.titleMedium?.copyWith(
            color:
                TtnflixColors.cellTextColor.platformBrightnessColor(context)),
        suffixIcon: isSuffixIcon
            ? Padding(
                padding: const EdgeInsets.fromLTRB(
                    TtnflixSpacing.spacing0,
                    TtnflixSpacing.spacing0,
                    TtnflixSpacing.spacing4,
                    TtnflixSpacing.spacing0),
                child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<TextFieldCubit>(context)
                          .showAndHidePassword();
                    },
                    child: Icon(
                      state?.isShowPassword ?? false
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      size: TtnflixSpacing.spacing24,
                      color: TtnflixColors.titleColor
                          .platformBrightnessColor(context),
                    )),
              )
            : null,
        errorStyle: TextStyle(
            color: TtnflixColors.frozenListYellow
                .platformBrightnessColor(context)));
  }

  void _onLogin({required BuildContext context}) {
    final cubit = BlocProvider.of<LoginCubit>(context);
    ShowLoader().showAlertDialog(context);
    cubit.signInUsingEmailPassword(
        email: emailTextController.text,
        password: passwordTextController.text);
  }
}
