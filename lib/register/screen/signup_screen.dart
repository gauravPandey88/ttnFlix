import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/register/cubit/register_cubit.dart';
import 'package:ttn_flix/register/cubit/register_state.dart';
import 'package:ttn_flix/register/model/user_model.dart';
import 'package:ttn_flix/register/widgets/multi_radio_singel_select.dart';
import 'package:ttn_flix/register/widgets/user_details.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
import 'package:ttn_flix/utils/show_snackbar.dart';


@RoutePage()
class SignupScreen extends StatelessWidget {

  SignupScreen({Key? key, SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences ?? SL.get<SharedPreferences>(),
        super(key: key);

  final SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Signup',
              style: TtnFlixTextStyle.defaultTextTheme.headlineLarge?.copyWith(
                  color: TtnflixColors.frozenListYellow
                      .platformBrightnessColor(context))),
          leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: TtnflixColors.frozenListYellow
                  .platformBrightnessColor(context),
            ),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
          if (state is RegisterLoadedState) {
            return
              SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(75)),
                          image: DecorationImage(
                              image: AssetImage(
                                    state.imagePath?.isEmpty ?? true
                                        ? "images/avtar_man.png"
                                        : state.imagePath ?? ""
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: TtnflixColors.frozenListYellow
                                  .platformBrightnessColor(context),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<RegisterCubit>(context)
                                      .addImage();
                                },
                                icon: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  UserDetails(
                      title: "Name",
                      controller: BlocProvider.of<RegisterCubit>(context)
                          .nameTextController),
                    UserDetails(
                        title: "Email Address",
                        controller: BlocProvider.of<RegisterCubit>(context)
                            .emailTextController,
                    errorText: state.emailIdErrorMessage.isNotEmpty ? state.emailIdErrorMessage : null,
                    onChanged: (value) {
                      BlocProvider.of<RegisterCubit>(context).onEmailIdChange(emailId: value.trim());
                    }),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                    child: Text("Date of birth",
                        style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                            ?.copyWith(color: Colors.grey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0),
                    child: TextField(
                      controller: BlocProvider.of<RegisterCubit>(context)
                          .dateofBirthController,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      onTap: () {
                        BlocProvider.of<RegisterCubit>(context)
                            .selectDate(context);
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: TtnflixColors.greyColor,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          labelText: BlocProvider.of<RegisterCubit>(context)
                                  .dateofBirthController
                                  .text
                                  .isEmpty
                              ? "Date of birth"
                              : BlocProvider.of<RegisterCubit>(context)
                                  .dateofBirthController
                                  .text,
                          labelStyle: TtnFlixTextStyle
                              .defaultTextTheme.titleMedium
                              ?.copyWith(color: Colors.grey),
                          hintText: "Date of birth",
                          hintStyle: TtnFlixTextStyle
                              .defaultTextTheme.titleMedium
                              ?.copyWith(color: Colors.grey)),
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
                      obscureText: state.isShowPassword ?? false ? false : true,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      controller: BlocProvider.of<RegisterCubit>(context)
                          .passwordTextController,
                      onChanged: (value) {
                        BlocProvider.of<RegisterCubit>(context).onPasswordChange(password: value.trim());
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
                                  BlocProvider.of<RegisterCubit>(context)
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
                          errorText: state.passwordErrorMessage.isNotEmpty ? state.passwordErrorMessage : null,
                          errorStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onError)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                    child: Text("Confirm Password",
                        style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                            ?.copyWith(color: Colors.grey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0),
                    child: TextField(
                      controller: BlocProvider.of<RegisterCubit>(context)
                  .confirmPasswordTextController,
                      obscureText:
                          state.isShowConfrimPassword ?? false ? false : true,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (value) {
                        BlocProvider.of<RegisterCubit>(context).onConfirmPasswordChange(password: value.trim());
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
                          hintText: "Confirm Password",
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<RegisterCubit>(context)
                                      .showAndHideConfirmPassword();
                                },
                                child: Icon(
                                  state.isShowConfrimPassword ?? false
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  size: 24,
                                  color: Colors.white,
                                )),
                          ),
                          hintStyle: TtnFlixTextStyle
                              .defaultTextTheme.titleMedium
                              ?.copyWith(color: Colors.grey),
                          errorText: state.confirmPasswordErrorMessage.isNotEmpty ? state.confirmPasswordErrorMessage : null,
                          errorStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onError)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                    child: Text("Gender",
                        style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                            ?.copyWith(color: Colors.grey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0),
                    child: MultiRadioSingleSelectWidget(
                      initialSelectedItem: state.initialSelectedGenderTypeIndex,
                      contentPadding: const EdgeInsets.only(
                          right: TtnflixSpacing.spacing40),
                      radioTitleList: state.genderTypeRadioList,
                      onSelectedIndex: (radioItemIndex) {
                        BlocProvider.of<RegisterCubit>(context)
                            .setSelectedGenderType(
                                selectedIndex: radioItemIndex);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Container(
                      height: 48,
                      width: 250,
                      decoration: BoxDecoration(
                          color: TtnflixColors.frozenListYellow
                              .platformBrightnessColor(context),
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          // BlocProvider.of<RegisterCubit>(context)
                          //     .loadSharedPrefs();
                          // context.router.push(const BottomBarNavigationRoute());
                          _onSignup(state, context);
                        },
                        child: const Text(
                           'Signup',
                          style: TextStyle(
                              color: Colors.black, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }

  void _onSignup(RegisterLoadedState state, BuildContext context) {
    final cubit = BlocProvider.of<RegisterCubit>(context);

    if (cubit.nameTextController.text.isEmpty) {
      "Please enter user name".showSnackbar(context);
    }else if (cubit.emailTextController.text.isEmpty) {
      "Please enter email".showSnackbar(context);
    } else if (state.emailIdErrorMessage.isNotEmpty) {
      "Please enter correct email".showSnackbar(context);
    }else if (cubit.dateofBirthController.text.isEmpty) {
      "Please enter date of birth".showSnackbar(context);
    } else if (cubit.passwordTextController.text.isEmpty) {
      "Please enter password".showSnackbar(context);
    } else if (state.passwordErrorMessage.isNotEmpty) {
      "Please enter correct password".showSnackbar(context);
    } else if (cubit.confirmPasswordTextController.text.isEmpty) {
      "Please enter confirm password".showSnackbar(context);
    } else if (state.confirmPasswordErrorMessage.isNotEmpty) {
      "Please enter correct confirm password".showSnackbar(context);
    } else if (cubit.passwordTextController.text != cubit.confirmPasswordTextController.text) {
      "Password mismatch".showSnackbar(context);
    } else {
      cubit.loadSharedPrefs();
      context.router.push(const BottomBarNavigationRoute());
    }



  }
}
