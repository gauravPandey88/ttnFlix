import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ttn_flix/generated/flutter_gen/assets.gen.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/register/cubit/register_cubit.dart';
import 'package:ttn_flix/register/cubit/register_state.dart';
import 'package:ttn_flix/register/cubit/text_field_cubit.dart';
import 'package:ttn_flix/register/cubit/text_field_state.dart';
import 'package:ttn_flix/register/widgets/multi_radio_singel_select.dart';
import 'package:ttn_flix/register/widgets/user_details.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
import 'package:ttn_flix/utils/date_picker.dart';
import 'package:ttn_flix/utils/date_util.dart';
import 'package:ttn_flix/utils/show_laoder.dart';
import 'package:ttn_flix/utils/show_snackbar.dart';
import 'package:ttn_flix/utils/validator.dart';

@RoutePage()
class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).signup,
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
          backgroundColor:
              TtnflixColors.textBlackColor.platformBrightnessColor(context),
        ),
        backgroundColor:
            TtnflixColors.textBlackColor.platformBrightnessColor(context),
        body: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
          if (state is RegisterErrorState) {
            Navigator.of(context).pop();
            state.message?.showSnackbar(context);
          } else if (state is RegisterSuccessState) {
            Navigator.of(context).pop();
            final cubit = BlocProvider.of<RegisterCubit>(context);
            cubit.loadSharedPrefs(
                name: nameTextController.text,
                email: emailTextController.text,
                password: cubit.getPasswordEncrypt(
                    encryptPassword: passwordTextController.text),
                dob: dateOfBirthController.text);
            context.router.push(const BottomBarNavigationRoute());
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(TtnflixSpacing.spacing10),
                      child: BlocBuilder<RegisterCubit, RegisterState>(
                        buildWhen: (previous, current) =>
                            current is ImageLoadedState,
                        builder: (context, state) {
                          if (state is ImageLoadedState) {
                            return Container(
                              height: TtnflixSpacing.spacing150,
                              width: TtnflixSpacing.spacing150,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(TtnflixSpacing.spacing75)),
                                image: DecorationImage(
                                    image: AssetImage(
                                        state.imagePath?.isEmpty ?? true
                                            ? Assets.images.avtarMan.path
                                            : state.imagePath ?? ""),
                                    fit: BoxFit.cover),
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: TtnflixColors.frozenListYellow
                                        .platformBrightnessColor(context),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            TtnflixSpacing.spacing30)),
                                  ),
                                  child: IconButton(
                                      onPressed: () async {

                                        BlocProvider.of<RegisterCubit>(context)
                                            .addImage();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt_rounded,
                                        color: TtnflixColors.textBlackColor
                                            .platformBrightnessColor(context),
                                      )),
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ),
                  UserDetails(
                      obscureText: false,
                      title: S.of(context).name,
                      controller: nameTextController,
                      validator: (value) =>
                          Validator.validateName(name: value)),
                  UserDetails(
                      obscureText: false,
                      title: S.of(context).emailAddress,
                      controller: emailTextController,
                      validator: (value) =>
                          Validator.validateEmail(email: value)),
                  UserDetails(
                    obscureText: false,
                    title: S.of(context).dateOfBirth,
                    controller: dateOfBirthController,
                    onTap: () {
                      initializeDateFormatting();
                      DatePicker(context, date: (date) {
                        dateOfBirthController.text =
                            getFormattedDate(date.toString());
                      }).show();
                    },
                    validator: (value) => Validator.emptyValidate(
                        value: value, message: S.of(context).enterDOB),
                    labelStyle: TtnFlixTextStyle.defaultTextTheme.titleMedium
                        ?.copyWith(
                            color: TtnflixColors.cellTextColor
                                .platformBrightnessColor(context)),
                  ),
                  BlocProvider(
                    create: (context) => TextFieldCubit(),
                    child: BlocBuilder<TextFieldCubit, TextFieldState>(
                      builder: (context, state) {
                        if (state is TextFieldLoadingState) {
                          return UserDetails(
                            obscureText:
                                state.isShowPassword ?? false ? false : true,
                            title: S.of(context).password,
                            controller: passwordTextController,
                            validator: (value) =>
                                Validator.validatePassword(password: value),
                            suffixIcon: Padding(
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
                                    state.isShowPassword ?? false
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    size: TtnflixSpacing.spacing24,
                                    color: TtnflixColors.titleColor
                                        .platformBrightnessColor(context),
                                  )),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  BlocProvider(
                    create: (context) => TextFieldCubit(),
                    child: BlocBuilder<TextFieldCubit, TextFieldState>(
                      builder: (context, state) {
                        if (state is TextFieldLoadingState) {
                          return UserDetails(
                            obscureText: state.isShowConfrimPassword ?? false
                                ? false
                                : true,
                            title: S.of(context).confirmPassword,
                            controller: confirmPasswordTextController,
                            validator: (value) =>
                                Validator.isValidConfirmPassword(
                                    password: value,
                                    matchPassword: passwordTextController.text),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  TtnflixSpacing.spacing0,
                                  TtnflixSpacing.spacing0,
                                  TtnflixSpacing.spacing4,
                                  TtnflixSpacing.spacing0),
                              child: GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<TextFieldCubit>(context)
                                        .showAndHideConfirmPassword();
                                  },
                                  child: Icon(
                                    state.isShowConfrimPassword ?? false
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    size: TtnflixSpacing.spacing24,
                                    color: TtnflixColors.titleColor
                                        .platformBrightnessColor(context),
                                  )),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: TtnflixSpacing.spacing20,
                        left: TtnflixSpacing.spacing10),
                    child: Text(S.of(context).gender,
                        style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                            ?.copyWith(
                                color: TtnflixColors.titleColor
                                    .platformBrightnessColor(context))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: TtnflixSpacing.spacing10,
                        right: TtnflixSpacing.spacing10),
                    child: BlocProvider(
                      create: (context) => TextFieldCubit(),
                      child: BlocBuilder<TextFieldCubit, TextFieldState>(
                        builder: (context, state) {
                          if (state is TextFieldLoadingState) {
                            return MultiRadioSingleSelectWidget(
                              initialSelectedItem:
                                  state.initialSelectedGenderTypeIndex,
                              contentPadding: const EdgeInsets.only(
                                  right: TtnflixSpacing.spacing10),
                              radioTitleList: state.genderTypeRadioList,
                              onSelectedIndex: (radioItemIndex) {
                                BlocProvider.of<RegisterCubit>(context)
                                    .setSelectedGenderType(
                                        selectedIndex: radioItemIndex);
                              },
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
                      height: TtnflixSpacing.spacing48,
                      width: TtnflixSpacing.spacing250,
                      decoration: BoxDecoration(
                          color: TtnflixColors.frozenListYellow
                              .platformBrightnessColor(context),
                          borderRadius:
                              BorderRadius.circular(TtnflixSpacing.spacing20)),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _onSignup(context);
                          }
                        },
                        child: Text(
                          S.of(context).signup,
                          style: TextStyle(
                              color: TtnflixColors.textBlackColor
                                  .platformBrightnessColor(context),
                              fontSize: TtnflixSpacing.spacing25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _onSignup(BuildContext context) {
    final cubit = BlocProvider.of<RegisterCubit>(context);
    ShowLoader().showAlertDialog(context);
    cubit.registerUsingEmailPassword(
      name: nameTextController.text,
        email: emailTextController.text,
        password: cubit.getPasswordEncrypt(
            encryptPassword: passwordTextController.text));
  }

}
