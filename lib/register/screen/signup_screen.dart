import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ttn_flix/generated/flutter_gen/assets.gen.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/register/cubit/register_cubit.dart';
import 'package:ttn_flix/register/cubit/register_state.dart';
import 'package:ttn_flix/register/widgets/multi_radio_singel_select.dart';
import 'package:ttn_flix/register/widgets/user_details.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
import 'package:ttn_flix/utils/date_picker.dart';
import 'package:ttn_flix/utils/date_util.dart';
import 'package:ttn_flix/utils/show_snackbar.dart';

@RoutePage()
class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

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
        body: BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
          if (state is RegisterLoadedState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(TtnflixSpacing.spacing10),
                      child: Container(
                        height: TtnflixSpacing.spacing150,
                        width: TtnflixSpacing.spacing150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(TtnflixSpacing.spacing75)),
                          image: DecorationImage(
                              image: AssetImage(state.imagePath?.isEmpty ?? true
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
                                  Radius.circular(TtnflixSpacing.spacing30)),
                            ),
                            child: IconButton(
                                onPressed: () {
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
                      ),
                    ),
                  ),
                  UserDetails(
                    obscureText: false,
                      title: S.of(context).name,
                      controller: BlocProvider.of<RegisterCubit>(context)
                          .nameTextController),
                  UserDetails(
                    obscureText: false,
                      title: S.of(context).emailAddress,
                      controller: BlocProvider.of<RegisterCubit>(context)
                          .emailTextController,
                      errorText: state.emailIdErrorMessage.isNotEmpty
                          ? state.emailIdErrorMessage
                          : null,
                      onChanged: (value) {
                        BlocProvider.of<RegisterCubit>(context)
                            .onEmailIdChange(emailId: value.trim());
                      }),
                  UserDetails(
                    obscureText: false,
                    title: S.of(context).dateOfBirth,
                    controller: BlocProvider.of<RegisterCubit>(context)
                        .dateofBirthController,
                    onTap: () {
                      initializeDateFormatting();
                      DatePicker(context, date: (date) {
                        BlocProvider.of<RegisterCubit>(context)
                            .dateofBirthController
                            .text = getFormattedDate(date.toString());
                      }).show();
                    },
                    labelText: BlocProvider.of<RegisterCubit>(context)
                        .dateofBirthController
                        .text
                        .isEmpty
                        ? S.of(context).dateOfBirth
                        : BlocProvider.of<RegisterCubit>(context)
                        .dateofBirthController
                        .text,
                    labelStyle: TtnFlixTextStyle
                        .defaultTextTheme.titleMedium
                        ?.copyWith(
                        color: TtnflixColors.cellTextColor
                            .platformBrightnessColor(context)),
                  ),
                  UserDetails(
                      obscureText: state.isShowPassword ?? false ? false : true,
                    title: S.of(context).password,
                    controller: BlocProvider.of<RegisterCubit>(context)
                        .passwordTextController,
                      onChanged: (value) {
                        BlocProvider.of<RegisterCubit>(context)
                            .onPasswordChange(password: value.trim());
                      },
                    errorText: state.passwordErrorMessage.isNotEmpty
                        ? state.passwordErrorMessage
                        : null,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          TtnflixSpacing.spacing0,
                          TtnflixSpacing.spacing0,
                          TtnflixSpacing.spacing4,
                          TtnflixSpacing.spacing0),
                      child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<RegisterCubit>(context)
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
                  ),
                  UserDetails(
                      obscureText: state.isShowConfrimPassword ?? false ? false : true,
                    title: S.of(context).confirmPassword,
                    controller: BlocProvider.of<RegisterCubit>(context)
                        .confirmPasswordTextController,
                    errorText: state.confirmPasswordErrorMessage.isNotEmpty
                        ? state.confirmPasswordErrorMessage
                        : null,
                    onChanged: (value) {
                      BlocProvider.of<RegisterCubit>(context)
                          .onConfirmPasswordChange(password: value.trim());
                    },
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          TtnflixSpacing.spacing0,
                          TtnflixSpacing.spacing0,
                          TtnflixSpacing.spacing4,
                          TtnflixSpacing.spacing0),
                      child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<RegisterCubit>(context)
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

                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: TtnflixSpacing.spacing20,
                        left: TtnflixSpacing.spacing10),
                    child: Text(S.of(context).gender,
                        style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                            ?.copyWith(color: TtnflixColors.titleColor
                            .platformBrightnessColor(context))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: TtnflixSpacing.spacing10,
                        right: TtnflixSpacing.spacing10),
                    child: MultiRadioSingleSelectWidget(
                      initialSelectedItem: state.initialSelectedGenderTypeIndex,
                      contentPadding: const EdgeInsets.only(
                          right: TtnflixSpacing.spacing10),
                      radioTitleList: state.genderTypeRadioList,
                      onSelectedIndex: (radioItemIndex) {
                        BlocProvider.of<RegisterCubit>(context)
                            .setSelectedGenderType(
                                selectedIndex: radioItemIndex);
                      },
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
                          _onSignup(state, context);
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

    cubit.registerUsingEmailPassword();




    // if (cubit.nameTextController.text.isEmpty) {
    //   S.of(context).enterUserName.showSnackbar(context);
    // } else if (cubit.emailTextController.text.isEmpty) {
    //   S.of(context).enterEmail.showSnackbar(context);
    // } else if (state.emailIdErrorMessage.isNotEmpty) {
    //   S.of(context).enterCorrectEmail.showSnackbar(context);
    // } else if (cubit.dateofBirthController.text.isEmpty) {
    //   S.of(context).enterDOB.showSnackbar(context);
    // } else if (cubit.passwordTextController.text.isEmpty) {
    //   S.of(context).enterPassword.showSnackbar(context);
    // } else if (state.passwordErrorMessage.isNotEmpty) {
    //   S.of(context).enterCorrectPassword.showSnackbar(context);
    // } else if (cubit.confirmPasswordTextController.text.isEmpty) {
    //   S.of(context).enterConfirmPassword.showSnackbar(context);
    // } else if (state.confirmPasswordErrorMessage.isNotEmpty) {
    //   S.of(context).enterCorrectConfirmPassword.showSnackbar(context);
    // } else if (cubit.passwordTextController.text !=
    //     cubit.confirmPasswordTextController.text) {
    //   S.of(context).passwordMismatch.showSnackbar(context);
    // } else {
    //   cubit.loadSharedPrefs();
    //   context.router.push(const BottomBarNavigationRoute());
    // }
  }
}
