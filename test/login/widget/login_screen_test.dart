import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/register/cubit/login_cubit.dart';
import 'package:ttn_flix/register/cubit/login_state.dart';
import 'package:ttn_flix/register/screen/login_screen.dart';
import 'login_screen_test.mocks.dart';

@GenerateMocks([LoginCubit, SharedPreferences, FirebaseAuth, User])
late SharedPreferences sharedPreferences;
late MockLoginCubit mockLoginCubit;
late LoginLoadedState state;
late Widget loginScreenWidget;
late MockUser mockUser;
late MockFirebaseAuth firebaseAuth;

void main() {
  setUpAll(() async {
    await S.load(const Locale('en'));
    sharedPreferences = MockSharedPreferences();
    final serviceLocator = ServiceLocator.ttnflixServiceLocator;
    serviceLocator.registerSingleton<SharedPreferences>(sharedPreferences);

    firebaseAuth = MockFirebaseAuth();
    serviceLocator.registerSingleton<FirebaseAuth>(firebaseAuth);

    when(sharedPreferences.getString(S.current.userData)).thenReturn('');

    mockLoginCubit = MockLoginCubit();
    state = const LoginLoadedState();
    mockUser = MockUser();

    when(mockLoginCubit.state).thenReturn(const LoginLoadedState());
    when(mockLoginCubit.stream).thenAnswer((realInvocation) => Stream.value(state));

    loginScreenWidget = MaterialApp(
      localizationsDelegates: const [S.delegate],
      home: Material(
        child: LoginScreen(),
      ),
    );
  });

  testWidgets('test for Login Loading State', (WidgetTester tester) async {
    when(mockLoginCubit.state).thenReturn(const LoginLoadingState());
    when(mockLoginCubit.stream).thenAnswer((realInvocation) => Stream.value(state));
    await tester.pumpWidget(loginScreenWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
  });
}
