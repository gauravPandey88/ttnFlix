import 'dart:async';
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/navigation/ttnflix_auto_route.dart';
import 'package:ttn_flix/register/model/user_model.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   Map<String, dynamic> userMap = jsonDecode(prefs.getString('userData') ?? "");
//   UserModel user = UserModel.fromJson(userMap);
//   runApp(SplashScreen(isLogin: user.isLogin));
// }

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, this.isLogin});
  final bool? isLogin;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(isLogin: isLogin),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    this.isLogin,
  });
  final bool? isLogin;
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> userMap =
          jsonDecode(prefs.getString('userData') ?? Map().toString());
      UserModel user = UserModel.fromJson(userMap);
      user.isLogin ?? false
          ? context.router.push(const BottomBarNavigationRoute())
          : context.router.push(LoginScreenRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}
