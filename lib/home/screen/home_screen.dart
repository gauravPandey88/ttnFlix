import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ttn_flix/home/repository/ttnflix_home_repositiory.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
   TtnflixHomeRepository().getHomePageDate();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
    );
  }
}
