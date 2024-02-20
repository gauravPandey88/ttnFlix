import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/di/app_launch_module.dart';
import 'package:ttn_flix/di/service_locator_impl.dart';
import 'package:ttn_flix/favourites/cubit/favourite_cubit.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/home/favouriteList/cubit/favourite_list_cubit.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
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
        localizationsDelegates: const [
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        darkTheme: TtnflixTheme.darkTheme,
        routerConfig: _appRouter.config(),

     );
  }

}



