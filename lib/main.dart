
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/di/app_launch_module.dart';
import 'package:ttn_flix/di/service_locator_impl.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/register/model/user_model.dart';
import 'package:ttn_flix/register/screen/login_screen.dart';
import 'package:ttn_flix/themes/ttnflix_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLaunchModule().initialise();
  await ServiceLocatorImpl().initialise();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = TtnflixAppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      theme: TtnflixTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      darkTheme: TtnflixTheme.darkTheme,
      routerConfig: _appRouter.config(),

     );
  }

}



