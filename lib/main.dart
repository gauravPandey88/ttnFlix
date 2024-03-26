import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ttn_flix/di/app_launch_module.dart';
import 'package:ttn_flix/di/service_locator_impl.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/themes/ttnflix_theme.dart';
 import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLaunchModule().initialise();
  await ServiceLocatorImpl().initialise();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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



