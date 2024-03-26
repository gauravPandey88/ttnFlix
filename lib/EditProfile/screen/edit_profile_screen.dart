import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ttn_flix/EditProfile/cubit/edit_profile_cubit.dart';
import 'package:ttn_flix/EditProfile/cubit/edit_profile_state.dart';
import 'package:ttn_flix/generated/flutter_gen/assets.gen.dart';
import 'package:ttn_flix/register/widgets/multi_radio_singel_select.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/utils/context_extension.dart';
import 'package:ttn_flix/utils/date_picker.dart';
import 'package:ttn_flix/utils/date_util.dart';
import 'package:ttn_flix/widgets/textfield/ttnflix_textfield.dart';

class _EditProfileConstant {
  static const String maleGender = "0";
  static const int maleSelectedIndex = 0;
  static const String femaleGender = "1";
  static const int femaleSelectedIndex = 1;
  static const int otherSelectedIndex = 2;
}

@RoutePage()
class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit()..getSavedInfo(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.editProfile,
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
        body: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            if (state is EditProfileLoadedState) {
              return SingleChildScrollView(
                  child: Center(
                child: SizedBox(
                  width:
                      context.isSmallScreen ? context.width : context.width / 2,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              SizedBox(
                                  height: TtnflixSpacing.spacing150,
                                  width: TtnflixSpacing.spacing150,
                                  child: state.imagePath != null
                                      ? CircleAvatar(
                                          backgroundImage:
                                              MemoryImage(Uint8List.fromList(state.imagePath!.codeUnits)))
                                      : state.genderType ==
                                              _EditProfileConstant.maleGender
                                          ? CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  Assets.images.avtarMan.path))
                                          : state.genderType ==
                                                  _EditProfileConstant
                                                      .femaleGender
                                              ? CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      Assets.images.avtarFemale
                                                          .path))
                                              : CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      Assets
                                                          .images
                                                          .avtarTransgender
                                                          .path))),
                              Positioned(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
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
                                          BlocProvider.of<EditProfileCubit>(
                                                  context)
                                              .addImage();
                                        },
                                        icon: Icon(
                                          Icons.camera_alt_rounded,
                                          color: TtnflixColors.textBlackColor
                                              .platformBrightnessColor(context),
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: TtnflixSpacing.spacing20,
                              left: TtnflixSpacing.spacing10),
                          child: Text(S.current.name,
                              style: TtnFlixTextStyle
                                  .defaultTextTheme.titleSmall
                                  ?.copyWith(
                                      color: TtnflixColors.titleColor
                                          .platformBrightnessColor(context))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: TtnflixSpacing.spacing10,
                              left: TtnflixSpacing.spacing10,
                              right: TtnflixSpacing.spacing10),
                          child: TtnflixTextField(
                            cursorColor: TtnflixColors.titleColor
                                .platformBrightnessColor(context),
                            style: TextStyle(
                                color: TtnflixColors.titleColor
                                    .platformBrightnessColor(context)),
                            controller:
                                BlocProvider.of<EditProfileCubit>(context)
                                    .nameTextController,
                            decoration: InputDecoration(
                                filled: true,
                                labelStyle: TtnFlixTextStyle
                                    .defaultTextTheme.titleMedium
                                    ?.copyWith(
                                        color: TtnflixColors.titleColor
                                            .platformBrightnessColor(context)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: TtnflixColors.titleColor
                                          .platformBrightnessColor(context)!),
                                ),
                                fillColor: TtnflixColors.inputBoxColor
                                    .platformBrightnessColor(context),
                                labelText: state.name?.isEmpty ?? false
                                    ? ''
                                    : state.name,
                                hintText: S.current.name,
                                hintStyle: TtnFlixTextStyle
                                    .defaultTextTheme.titleMedium
                                    ?.copyWith(
                                        color: TtnflixColors.cellTextColor
                                            .platformBrightnessColor(context)),
                                errorStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onError)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: TtnflixSpacing.spacing20,
                              left: TtnflixSpacing.spacing10),
                          child: Text(S.current.dateOfBirth,
                              style: TtnFlixTextStyle
                                  .defaultTextTheme.titleSmall
                                  ?.copyWith(
                                      color: TtnflixColors.titleColor
                                          .platformBrightnessColor(context))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: TtnflixSpacing.spacing10,
                              left: TtnflixSpacing.spacing10,
                              right: TtnflixSpacing.spacing10),
                          child: TtnflixTextField(
                            cursorColor: TtnflixColors.titleColor
                                .platformBrightnessColor(context),
                            style: TextStyle(
                                color: TtnflixColors.titleColor
                                    .platformBrightnessColor(context)),
                            controller:
                                BlocProvider.of<EditProfileCubit>(context)
                                    .dateofBirthController,
                            onTap: () {
                              initializeDateFormatting();
                              DatePicker(context, date: (date) {
                                BlocProvider.of<EditProfileCubit>(context)
                                    .dateofBirthController
                                    .text = getFormattedDate(date.toString());
                              }).show();
                            },
                            decoration: InputDecoration(
                                filled: true,
                                labelStyle: TtnFlixTextStyle
                                    .defaultTextTheme.titleMedium
                                    ?.copyWith(
                                        color: TtnflixColors.titleColor
                                            .platformBrightnessColor(context)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: TtnflixColors.titleColor
                                          .platformBrightnessColor(context)!),
                                ),
                                fillColor: TtnflixColors.inputBoxColor
                                    .platformBrightnessColor(context),
                                labelText: state.dateofBirth?.isEmpty ?? false
                                    ? ''
                                    : state.dateofBirth,
                                hintText: S.current.dateOfBirth,
                                hintStyle: TtnFlixTextStyle
                                    .defaultTextTheme.titleMedium
                                    ?.copyWith(
                                        color: TtnflixColors.cellTextColor
                                            .platformBrightnessColor(context)),
                                errorStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onError)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: TtnflixSpacing.spacing20,
                              left: TtnflixSpacing.spacing10),
                          child: Text(S.current.password,
                              style: TtnFlixTextStyle
                                  .defaultTextTheme.titleSmall
                                  ?.copyWith(
                                      color: TtnflixColors.titleColor
                                          .platformBrightnessColor(context))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: TtnflixSpacing.spacing10,
                              left: TtnflixSpacing.spacing10,
                              right: TtnflixSpacing.spacing10),
                          child: TtnflixTextField(
                            obscureText:
                                state.isShowPassword ?? false ? false : true,
                            cursorColor: TtnflixColors.titleColor
                                .platformBrightnessColor(context),
                            style: TextStyle(
                                color: TtnflixColors.titleColor
                                    .platformBrightnessColor(context)),
                            controller:
                                BlocProvider.of<EditProfileCubit>(context)
                                    .passwordTextController,
                            onChanged: (value) {
                              BlocProvider.of<EditProfileCubit>(context)
                                  .onPasswordChange(password: value.trim());
                            },
                            decoration: InputDecoration(
                                filled: true,
                                labelStyle: TtnFlixTextStyle
                                    .defaultTextTheme.titleMedium
                                    ?.copyWith(
                                        color: TtnflixColors.titleColor
                                            .platformBrightnessColor(context)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: TtnflixColors.titleColor
                                          .platformBrightnessColor(context)!),
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      TtnflixSpacing.spacing0,
                                      TtnflixSpacing.spacing0,
                                      TtnflixSpacing.spacing4,
                                      TtnflixSpacing.spacing0),
                                  child: GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<EditProfileCubit>(
                                                context)
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
                                fillColor: TtnflixColors.inputBoxColor
                                    .platformBrightnessColor(context),
                                hintText: S.current.password,
                                hintStyle: TtnFlixTextStyle
                                    .defaultTextTheme.titleMedium
                                    ?.copyWith(
                                        color: TtnflixColors.cellTextColor
                                            .platformBrightnessColor(context)),
                                errorText: state.passwordErrorMessage.isNotEmpty
                                    ? state.passwordErrorMessage
                                    : null,
                                errorStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onError)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: TtnflixSpacing.spacing20,
                              left: TtnflixSpacing.spacing10),
                          child: Text(S.current.gender,
                              style: TtnFlixTextStyle
                                  .defaultTextTheme.titleSmall
                                  ?.copyWith(
                                      color: TtnflixColors.titleColor
                                          .platformBrightnessColor(context))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: TtnflixSpacing.spacing10,
                              left: TtnflixSpacing.spacing10,
                              right: TtnflixSpacing.spacing10),
                          child: MultiRadioSingleSelectWidget(
                            initialSelectedItem: state.genderType ==
                                    _EditProfileConstant.maleGender
                                ? _EditProfileConstant.maleSelectedIndex
                                : state.genderType ==
                                        _EditProfileConstant.femaleGender
                                    ? _EditProfileConstant.femaleSelectedIndex
                                    : _EditProfileConstant.otherSelectedIndex,
                            contentPadding: const EdgeInsets.only(
                                right: TtnflixSpacing.spacing10),
                            radioTitleList: state.genderTypeRadioList,
                            onSelectedIndex: (radioItemIndex) {
                              BlocProvider.of<EditProfileCubit>(context)
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
                                borderRadius: BorderRadius.circular(
                                    TtnflixSpacing.spacing20)),
                            child: TextButton(
                              onPressed: () {
                                BlocProvider.of<EditProfileCubit>(context)
                                    .loadSharedPrefs(
                                        image: state.imagePath,
                                        name: state.name,
                                        gender: state.genderType,
                                        dateOfBirth: state.dateofBirth,
                                        password: state.password,
                                        email: state.emailId);
                                context.router.pop();
                              },
                              child: Text(
                                S.current.update,
                                style: TextStyle(
                                    color: TtnflixColors.textBlackColor
                                        .platformBrightnessColor(context),
                                    fontSize: TtnflixSpacing.spacing25),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ));
            } else {}
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
