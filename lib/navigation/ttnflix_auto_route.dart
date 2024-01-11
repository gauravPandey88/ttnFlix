import 'package:auto_route/auto_route.dart';
import 'package:ttn_flix/home/screen/home_screen.dart';


part 'ttnflix_auto_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen')
class TtnflixAppRouter extends _$TtnflixAppRouter{
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeScreenRoute.page, initial: true),
  ];
}