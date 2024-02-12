import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttn_flix/accounts/screen/accounts_screen.dart';
import 'package:ttn_flix/favourites/screen/favourites_screen.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/home/cubit/home_cubit.dart';
import 'package:ttn_flix/home/repository/ttnflix_home_repositiory.dart';
import 'package:ttn_flix/home/screen/home_screen.dart';
import 'package:ttn_flix/themes/ttnflix_colors.dart';

class _BottomBarConstant {
  static const int selectedIndex = 0;
  static double fontSize = 30;


}

@RoutePage()
class BottomBarNavigation extends StatelessWidget {
   const BottomBarNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = _BottomBarConstant.selectedIndex;
  static TextStyle optionStyle =
  TextStyle(fontSize: _BottomBarConstant.fontSize, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const FavouritesScreen(),
    AccountsScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: TtnflixColors.textBlackColor.platformBrightnessColor(context),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.home),
            label: S.current.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.heart_fill),
            label: S.current.favourites,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.profile_circled),
            label: S.current.accounts,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: TtnflixColors.frozenListYellow
            .platformBrightnessColor(context),
        unselectedItemColor: TtnflixColors.titleColor.platformBrightnessColor(context),
        onTap: _onItemTapped,
      ),
    );
  }
}
