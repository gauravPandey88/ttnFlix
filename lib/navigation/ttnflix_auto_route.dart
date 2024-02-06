import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/EditProfile/screen/edit_profile_screen.dart';
import 'package:ttn_flix/accounts/screen/accounts_screen.dart';
import 'package:ttn_flix/detail/screen/movie_detail_screen.dart';
import 'package:ttn_flix/detail/widget/icon_widget.dart';
import 'package:ttn_flix/favourites/screen/favourites_screen.dart';
import 'package:ttn_flix/home/model/ttnflix_movies.dart';
import 'package:ttn_flix/home/screen/home_screen.dart';
import 'package:ttn_flix/register/screen/login_screen.dart';
import 'package:ttn_flix/register/screen/signup_screen.dart';
import 'package:ttn_flix/tabbar/bottom_bar_navigation.dart';

import '../splash/screen/splash_screen.dart';

part 'ttnflix_auto_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen')
class TtnflixAppRouter extends _$TtnflixAppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashScreenRoute.page, initial: true),
        AutoRoute(page: LoginScreenRoute.page),
        AutoRoute(page: SignupScreenRoute.page),
        AutoRoute(page: BottomBarNavigationRoute.page),
        AutoRoute(page: HomeScreenRoute.page),
        AutoRoute(page: MovieDetailScreenRoute.page),
        AutoRoute(page: EditProfileRoute.page),
      ];
}
