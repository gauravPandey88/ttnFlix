import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/accounts/cubit/accounts_cubit.dart';
import 'package:ttn_flix/accounts/cubit/accounts_state.dart';
import 'package:ttn_flix/accounts/widgets/profile_list.dart';
import 'dart:convert';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/register/model/user_model.dart';
import 'package:ttn_flix/register/screen/signup_screen.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
import 'package:ttn_flix/utils/app_alert.dart';

@RoutePage()
class AccountsScreen extends StatelessWidget {
  AccountsScreen({Key? key, SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences ?? SL.get<SharedPreferences>(),
        super(key: key);

  final SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountsCubit>(
      create: (_) => AccountsCubit()..getSavedInfo(),
      child: AccountBody(
        sharedPreferences: _sharedPreferences,
      ),
    );
  }
}

class AccountBody extends StatelessWidget {
  const AccountBody({
    super.key,
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountsCubit, AccountsState>(
      builder: (context, state) {
        final currentState = state;
        if (currentState is AccountLoadedState) {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text('Profile',
                    style: TtnFlixTextStyle.defaultTextTheme.headlineSmall
                        ?.copyWith(
                            color: TtnflixColors.frozenListYellow
                                .platformBrightnessColor(context))),
              ),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      context.router.push(const EditProfileRoute()).then(
                        (value) {
                          BlocProvider.of<AccountsCubit>(context)
                              .getSavedInfo();
                        },
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: TtnflixColors.frozenListYellow
                          .platformBrightnessColor(context),
                    ))
              ],
              leading: IconButton(
                icon: Icon(Icons.logout,
                    color: TtnflixColors.frozenListYellow
                        .platformBrightnessColor(context)),
                tooltip: 'Logout',
                onPressed: () {
                  _logout(context, currentState);
                },
              ),
              backgroundColor: Colors.black,
            ),
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              image: AssetImage(currentState.image != null
                                  ? currentState.gender == "0"
                                      ? "images/avtar_man.png"
                                      : "images/avtar_female.png"
                                  : currentState.image ?? ''),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(currentState.name ?? '-',
                          style: TtnFlixTextStyle.defaultTextTheme.titleLarge
                              ?.copyWith(color: Colors.grey)),
                    ),
                  ),
                  ProfileList(
                      context: context,
                      tittle: "Email",
                      icon: Icons.email,
                      data: currentState.emailAddress),
                  Divider(
                    height: 20,
                    color: TtnflixColors.frozenListYellow
                        .platformBrightnessColor(context),
                  ),
                  ProfileList(
                      context: context,
                      icon: Icons.calendar_month,
                      tittle: "Date of Birth",
                      data: currentState.dateOfBirth),
                  Divider(
                    height: 20,
                    color: TtnflixColors.frozenListYellow
                        .platformBrightnessColor(context),
                  ),
                  ProfileList(
                      context: context,
                      icon: currentState.gender == "0"
                          ? Icons.male
                          : Icons.female,
                      tittle: "Gender",
                      data: currentState.gender == "0" ? "Male" : "Female"),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  void _logout(BuildContext context, AccountLoadedState currentState) {
    AppAlert(
        title: 'Logout',
        message: 'Are you sure to logout?',
        confirmBtnText: 'Log Out',
        confirmTap: () {
          BlocProvider.of<AccountsCubit>(context).loadSharedPrefs(
              image: currentState.image,
              name: currentState.name,
              gender: currentState.gender,
              dateofBirth: currentState.dateOfBirth,
              password: currentState.password,
              isLogin: false,
              email: currentState.emailAddress);
          context.router.push(
            LoginScreenRoute(),
          );
        }).showDialogBox(context);
  }
}
