

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/utils/database_Manager.dart';

class ServiceLocatorImpl implements ServiceLocator {
  static final serviceLocator = GetIt.instance;

  @override
  Future<void> initialise() async {

    if (!isRegistered<ServiceLocator>()) {
      serviceLocator.registerSingleton<ServiceLocator>(
          ServiceLocator.ttnflixServiceLocator);
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();

     _initSharedPref();

    if (!isRegistered<DBManager>()) {
      serviceLocator.registerSingleton<DBManager>(
          DBManager());
    }

   // serviceLocator.registerSingleton<DBManager>(DBManager());

  }
  Future<void> _initSharedPref() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (!isRegistered<SharedPreferences>()) {
      serviceLocator.registerSingleton<SharedPreferences>(
          sharedPreferences);
    }
    // _serviceLocator.registerSingleton<SharedPreferences>(sharedPreferences);
  }

  @override
  bool isRegistered<T extends Object>(
      {Object? instance, String? instanceName}) {
    return serviceLocator.isRegistered<T>(instance: instance);
  }

  @override
  void registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    serviceLocator.registerLazySingleton<T>(factoryFunc,
        instanceName: instanceName, dispose: dispose);
  }

  @override
  void registerLazySingletonAsync<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    serviceLocator.registerLazySingletonAsync<T>(factoryFunc,
        instanceName: instanceName, dispose: dispose);
  }

  @override
  void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
    DisposingFunc<T>? dispose,
  }) {
    serviceLocator.registerSingleton<T>(instance,
        instanceName: instanceName,
        signalsReady: signalsReady,
        dispose: dispose);
  }

  @override
  void registerSingletonWithDependencies<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    Iterable<Type>? dependsOn,
    bool? signalsReady,
    DisposingFunc<T>? dispose,
  }) {
    serviceLocator.registerSingletonWithDependencies<T>(factoryFunc,
        instanceName: instanceName,
        dependsOn: dependsOn,
        signalsReady: signalsReady,
        dispose: dispose);
  }

  @override
  T get<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) {
    return serviceLocator.get<T>(
        instanceName: instanceName, param1: param1, param2: param2);
  }

  @override
  Future<T> getAsync<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) {
    return serviceLocator.getAsync<T>(
        instanceName: instanceName, param1: param1, param2: param2);
  }

  @override
  Future<void> isReady<T extends Object>({
    Object? instance,
    String? instanceName,
    Duration? timeout,
    Object? callee,
  }) {
    return serviceLocator.isReady<T>(
        instance: instance,
        instanceName: instanceName,
        timeout: timeout,
        callee: callee);
  }

  @override
  bool isReadySync<T extends Object>({
    Object? instance,
    String? instanceName,
  }) {
    return serviceLocator.isReadySync<T>(
        instance: instance, instanceName: instanceName);
  }
}
