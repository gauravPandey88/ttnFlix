// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/register/model/user_model.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';


class _SplashScreenConstant {
  static const int timeSession = 15;
  static const int splashTime = 3;
}

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: S.of(context).splashScreen,
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: _SplashScreenConstant.splashTime), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> userMap =
          jsonDecode(prefs.getString(S.current.userData) ?? {}.toString());
      UserModel user = UserModel.fromJson(userMap);

      user.isLogin ?? false
          ? checkTimestamp(user.timestamp ?? 0)
              // ignore: use_build_context_synchronously
              ? context.router.push(LoginScreenRoute())
              : context.router.push(const BottomBarNavigationRoute())
          : checkTimestamp(user.timestamp ?? 0)
              ? context.router.push(LoginScreenRoute())
              : user.isOnboardingShow ?? false
                  ? context.router.push(LoginScreenRoute())
                  : context.router.push(OnBoardingScreenRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: TtnflixColors.pureWhite.platformBrightnessColor(context),
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}

bool checkTimestamp(int timestamp) {
  if (timestamp > 0) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    int time;
    time = diff.inMinutes;

    return time > _SplashScreenConstant.timeSession ? true : false;
  } else {
    return false;
  }
}
