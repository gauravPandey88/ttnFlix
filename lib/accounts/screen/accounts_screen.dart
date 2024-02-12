import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/accounts/cubit/accounts_cubit.dart';
import 'package:ttn_flix/accounts/cubit/accounts_state.dart';
import 'package:ttn_flix/accounts/widgets/profile_list.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/generated/flutter_gen/assets.gen.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';
import 'package:ttn_flix/themes/ttnflix_typography.dart';
import 'package:ttn_flix/utils/app_alert.dart';

class _AccountsScreenConstant {
  static const String maleGender = "0";
  static const String femaleGender = "1";
}

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
                child: Text(S.current.profile,
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
                tooltip: S.current.logout,
                onPressed: () {
                  _logout(context, currentState);
                },
              ),
              backgroundColor:
                  TtnflixColors.textBlackColor.platformBrightnessColor(context),
            ),
            backgroundColor:
                TtnflixColors.textBlackColor.platformBrightnessColor(context),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              image: AssetImage(currentState.image == ''
                                  ? currentState.gender == _AccountsScreenConstant.maleGender
                                      ? Assets.images.avtarMan.path
                                      : currentState.gender == _AccountsScreenConstant.femaleGender
                                          ? Assets.images.avtarFemale.path
                                          : Assets.images.avtarTransgender.path
                                  : currentState.image ?? ''),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: TtnflixSpacing.spacing10),
                      child: Text(currentState.name ?? '-',
                          style: TtnFlixTextStyle.defaultTextTheme.titleLarge
                              ?.copyWith(color: TtnflixColors.titleColor.platformBrightnessColor(context))),
                    ),
                  ),
                  ProfileList(
                      context: context,
                      tittle: S.current.email,
                      icon: Icons.email,
                      data: currentState.emailAddress),
                  Divider(
                    height: TtnflixSpacing.spacing20,
                    color: TtnflixColors.frozenListYellow
                        .platformBrightnessColor(context),
                  ),
                  ProfileList(
                      context: context,
                      icon: Icons.calendar_month,
                      tittle: S.current.dateOfBirth,
                      data: currentState.dateOfBirth),
                  Divider(
                    height: TtnflixSpacing.spacing20,
                    color: TtnflixColors.frozenListYellow
                        .platformBrightnessColor(context),
                  ),
                  ProfileList(
                      context: context,
                      icon: currentState.gender ==
                              _AccountsScreenConstant.maleGender
                          ? Icons.male
                          : currentState.gender ==
                                  _AccountsScreenConstant.femaleGender
                              ? Icons.female
                              : Icons.transgender,
                      tittle: S.current.gender,
                      data: currentState.gender ==
                              _AccountsScreenConstant.maleGender
                          ? S.current.male
                          : currentState.gender ==
                                  _AccountsScreenConstant.femaleGender
                              ? S.current.female
                              : S.current.other),
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
        title: S.current.logout,
        message: S.current.logoutTitle,
        confirmBtnText: S.current.logout,
        confirmTap: () {
          BlocProvider.of<AccountsCubit>(context).loadSharedPrefs(
              image: currentState.image,
              name: currentState.name,
              gender: currentState.gender,
              dateofBirth: currentState.dateOfBirth,
              password: currentState.password,
              isLogin: false,
              timeStamp: currentState.timeStamp,
              email: currentState.emailAddress);
          context.router.push(
            LoginScreenRoute(),
          );
        }).showDialogBox(context);
  }
}
