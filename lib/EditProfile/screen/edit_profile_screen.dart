import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/EditProfile/cubit/edit_profile_cubit.dart';
import 'package:ttn_flix/EditProfile/cubit/edit_profile_state.dart';
import 'package:ttn_flix/register/widgets/multi_radio_singel_select.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';

@RoutePage()
class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit()..getSavedInfo(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('EditProfile',
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
        body: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            if (state is EditProfileLoadedState) {
              return SingleChildScrollView(
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
                                      ?  state.genderType == "0" ? "images/avtar_man.png" : "images/avtar_female.png"
                                      : state.imagePath ?? "",
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
                                    BlocProvider.of<EditProfileCubit>(context)
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                      child: Text("Name",
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(color: Colors.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0),
                      child: TextField(
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        controller: BlocProvider.of<EditProfileCubit>(context)
                            .nameTextController,
                        decoration: InputDecoration(
                            filled: true,
                            labelStyle: TtnFlixTextStyle
                                .defaultTextTheme.titleMedium
                                ?.copyWith(color: Colors.white),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            fillColor: TtnflixColors.greyColor,
                            labelText:
                                state.name?.isEmpty ?? false ? '' : state.name,
                            hintText: "Name",
                            hintStyle: TtnFlixTextStyle
                                .defaultTextTheme.titleMedium
                                ?.copyWith(color: Colors.grey),
                            errorStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onError)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                      child: Text("Date of Birth",
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(color: Colors.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0),
                      child: TextField(
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        controller: BlocProvider.of<EditProfileCubit>(context)
                            .dateofBirthController,
                        onTap: () {
                          BlocProvider.of<EditProfileCubit>(context)
                              .selectDate(context);
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
                            labelText: state.dateofBirth?.isEmpty ?? false
                                ? ''
                                : state.dateofBirth,
                            hintText: "Date of Birth",
                            hintStyle: TtnFlixTextStyle
                                .defaultTextTheme.titleMedium
                                ?.copyWith(color: Colors.grey),
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
                            obscureText: state.isShowPassword ?? false ? false : true,
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            controller: BlocProvider.of<EditProfileCubit>(context)
                                .passwordTextController,
                            onChanged: (value) {
                              BlocProvider.of<EditProfileCubit>(context).onPasswordChange(password: value.trim());
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
                                        BlocProvider.of<EditProfileCubit>(context)
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
                                labelText: state.password.isEmpty
                                    ? ''
                                    : state.password,
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
                      child: Text("Gender",
                          style: TtnFlixTextStyle.defaultTextTheme.titleSmall
                              ?.copyWith(color: Colors.grey)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0),
                      child: MultiRadioSingleSelectWidget(
                        initialSelectedItem: state.genderType == "0" ? 0 : 1,
                        contentPadding: const EdgeInsets.only(
                            right: TtnflixSpacing.spacing40),
                        radioTitleList: state.genderTypeRadioList,
                        onSelectedIndex: (radioItemIndex) {
                          BlocProvider.of<EditProfileCubit>(context)
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
                            BlocProvider.of<EditProfileCubit>(context)
                                .loadSharedPrefs(
                                    image: state.imagePath,
                                    name: state.name,
                                    gender: state.genderType,
                                    dateofBirth: state.dateofBirth,
                            password: state.password,
                            email: state.emailId);
                            context.router.pop();
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.black, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ]));
            } else {}
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
