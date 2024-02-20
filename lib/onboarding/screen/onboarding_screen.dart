import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/generated/flutter_gen/assets.gen.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/register/model/user_model.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';
import 'package:ttn_flix/themes/ttnflix_spacing.dart';

@RoutePage()
class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key, SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences ?? SL.get<SharedPreferences>(),
        super(key: key);

  final SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          TtnflixColors.textBlackColor.platformBrightnessColor(context),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.onboarding.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: TtnflixSpacing.spacing50),
            child: Container(
              height: TtnflixSpacing.spacing50,
              width: TtnflixSpacing.spacing250,
              decoration: BoxDecoration(
                  color: TtnflixColors.skyRacing1Color
                      .platformBrightnessColor(context),
                  borderRadius:
                      BorderRadius.circular(TtnflixSpacing.spacing20)),
              child: TextButton(
                onPressed: () {
                  loadSharedPrefs();
                  context.router.push(LoginScreenRoute());
                },
                child: Text(
                  S.of(context).onboarding,
                  style: TextStyle(
                      color:
                          TtnflixColors.white.platformBrightnessColor(context),
                      fontSize: TtnflixSpacing.spacing22),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  loadSharedPrefs() async {
    UserModel user1 = UserModel(
      isOnboardingShow: true,
    );
    String user = jsonEncode(user1);
    _sharedPreferences.setString(S.current.userData, user);
  }
}


