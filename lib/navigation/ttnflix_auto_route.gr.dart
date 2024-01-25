// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'ttnflix_auto_route.dart';

abstract class _$TtnflixAppRouter extends RootStackRouter {
  // ignore: unused_element
  _$TtnflixAppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AccountsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<AccountsScreenRouteArgs>(
          orElse: () => const AccountsScreenRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AccountsScreen(
          key: args.key,
          sharedPreferences: args.sharedPreferences,
        ),
      );
    },
    BottomBarNavigationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BottomBarNavigation(),
      );
    },
    EditProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditProfile(),
      );
    },
    FavouritesScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavouritesScreen(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    IconWidgetRoute.name: (routeData) {
      final args = routeData.argsAs<IconWidgetRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: IconWidget(
          key: args.key,
          movie: args.movie,
          isFavourite: args.isFavourite,
        ),
      );
    },
    LoginScreenRoute.name: (routeData) {
      final args = routeData.argsAs<LoginScreenRouteArgs>(
          orElse: () => const LoginScreenRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginScreen(
          key: args.key,
          sharedPreferences: args.sharedPreferences,
        ),
      );
    },
    MovieDetailScreenRoute.name: (routeData) {
      final args = routeData.argsAs<MovieDetailScreenRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MovieDetailScreen(
          key: args.key,
          movie: args.movie,
          isFavourite: args.isFavourite,
        ),
      );
    },
    SignupScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SignupScreenRouteArgs>(
          orElse: () => const SignupScreenRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignupScreen(
          key: args.key,
          sharedPreferences: args.sharedPreferences,
        ),
      );
    },
    SplashScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SplashScreenRouteArgs>(
          orElse: () => const SplashScreenRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SplashScreen(
          key: args.key,
          isLogin: args.isLogin,
        ),
      );
    },
  };
}

/// generated route for
/// [AccountsScreen]
class AccountsScreenRoute extends PageRouteInfo<AccountsScreenRouteArgs> {
  AccountsScreenRoute({
    Key? key,
    SharedPreferences? sharedPreferences,
    List<PageRouteInfo>? children,
  }) : super(
          AccountsScreenRoute.name,
          args: AccountsScreenRouteArgs(
            key: key,
            sharedPreferences: sharedPreferences,
          ),
          initialChildren: children,
        );

  static const String name = 'AccountsScreenRoute';

  static const PageInfo<AccountsScreenRouteArgs> page =
      PageInfo<AccountsScreenRouteArgs>(name);
}

class AccountsScreenRouteArgs {
  const AccountsScreenRouteArgs({
    this.key,
    this.sharedPreferences,
  });

  final Key? key;

  final SharedPreferences? sharedPreferences;

  @override
  String toString() {
    return 'AccountsScreenRouteArgs{key: $key, sharedPreferences: $sharedPreferences}';
  }
}

/// generated route for
/// [BottomBarNavigation]
class BottomBarNavigationRoute extends PageRouteInfo<void> {
  const BottomBarNavigationRoute({List<PageRouteInfo>? children})
      : super(
          BottomBarNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'BottomBarNavigationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditProfile]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavouritesScreen]
class FavouritesScreenRoute extends PageRouteInfo<void> {
  const FavouritesScreenRoute({List<PageRouteInfo>? children})
      : super(
          FavouritesScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavouritesScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeScreenRoute extends PageRouteInfo<void> {
  const HomeScreenRoute({List<PageRouteInfo>? children})
      : super(
          HomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [IconWidget]
class IconWidgetRoute extends PageRouteInfo<IconWidgetRouteArgs> {
  IconWidgetRoute({
    Key? key,
    required Movie movie,
    required bool isFavourite,
    List<PageRouteInfo>? children,
  }) : super(
          IconWidgetRoute.name,
          args: IconWidgetRouteArgs(
            key: key,
            movie: movie,
            isFavourite: isFavourite,
          ),
          initialChildren: children,
        );

  static const String name = 'IconWidgetRoute';

  static const PageInfo<IconWidgetRouteArgs> page =
      PageInfo<IconWidgetRouteArgs>(name);
}

class IconWidgetRouteArgs {
  const IconWidgetRouteArgs({
    this.key,
    required this.movie,
    required this.isFavourite,
  });

  final Key? key;

  final Movie movie;

  final bool isFavourite;

  @override
  String toString() {
    return 'IconWidgetRouteArgs{key: $key, movie: $movie, isFavourite: $isFavourite}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginScreenRoute extends PageRouteInfo<LoginScreenRouteArgs> {
  LoginScreenRoute({
    Key? key,
    SharedPreferences? sharedPreferences,
    List<PageRouteInfo>? children,
  }) : super(
          LoginScreenRoute.name,
          args: LoginScreenRouteArgs(
            key: key,
            sharedPreferences: sharedPreferences,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static const PageInfo<LoginScreenRouteArgs> page =
      PageInfo<LoginScreenRouteArgs>(name);
}

class LoginScreenRouteArgs {
  const LoginScreenRouteArgs({
    this.key,
    this.sharedPreferences,
  });

  final Key? key;

  final SharedPreferences? sharedPreferences;

  @override
  String toString() {
    return 'LoginScreenRouteArgs{key: $key, sharedPreferences: $sharedPreferences}';
  }
}

/// generated route for
/// [MovieDetailScreen]
class MovieDetailScreenRoute extends PageRouteInfo<MovieDetailScreenRouteArgs> {
  MovieDetailScreenRoute({
    Key? key,
    required Movie movie,
    required bool isFavourite,
    List<PageRouteInfo>? children,
  }) : super(
          MovieDetailScreenRoute.name,
          args: MovieDetailScreenRouteArgs(
            key: key,
            movie: movie,
            isFavourite: isFavourite,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieDetailScreenRoute';

  static const PageInfo<MovieDetailScreenRouteArgs> page =
      PageInfo<MovieDetailScreenRouteArgs>(name);
}

class MovieDetailScreenRouteArgs {
  const MovieDetailScreenRouteArgs({
    this.key,
    required this.movie,
    required this.isFavourite,
  });

  final Key? key;

  final Movie movie;

  final bool isFavourite;

  @override
  String toString() {
    return 'MovieDetailScreenRouteArgs{key: $key, movie: $movie, isFavourite: $isFavourite}';
  }
}

/// generated route for
/// [SignupScreen]
class SignupScreenRoute extends PageRouteInfo<SignupScreenRouteArgs> {
  SignupScreenRoute({
    Key? key,
    SharedPreferences? sharedPreferences,
    List<PageRouteInfo>? children,
  }) : super(
          SignupScreenRoute.name,
          args: SignupScreenRouteArgs(
            key: key,
            sharedPreferences: sharedPreferences,
          ),
          initialChildren: children,
        );

  static const String name = 'SignupScreenRoute';

  static const PageInfo<SignupScreenRouteArgs> page =
      PageInfo<SignupScreenRouteArgs>(name);
}

class SignupScreenRouteArgs {
  const SignupScreenRouteArgs({
    this.key,
    this.sharedPreferences,
  });

  final Key? key;

  final SharedPreferences? sharedPreferences;

  @override
  String toString() {
    return 'SignupScreenRouteArgs{key: $key, sharedPreferences: $sharedPreferences}';
  }
}

/// generated route for
/// [SplashScreen]
class SplashScreenRoute extends PageRouteInfo<SplashScreenRouteArgs> {
  SplashScreenRoute({
    Key? key,
    bool? isLogin,
    List<PageRouteInfo>? children,
  }) : super(
          SplashScreenRoute.name,
          args: SplashScreenRouteArgs(
            key: key,
            isLogin: isLogin,
          ),
          initialChildren: children,
        );

  static const String name = 'SplashScreenRoute';

  static const PageInfo<SplashScreenRouteArgs> page =
      PageInfo<SplashScreenRouteArgs>(name);
}

class SplashScreenRouteArgs {
  const SplashScreenRouteArgs({
    this.key,
    this.isLogin,
  });

  final Key? key;

  final bool? isLogin;

  @override
  String toString() {
    return 'SplashScreenRouteArgs{key: $key, isLogin: $isLogin}';
  }
}
