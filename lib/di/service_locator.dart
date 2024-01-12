

import 'package:get_it/get_it.dart';
import 'package:ttn_flix/di/service_locator_impl.dart';

abstract class ServiceLocator {
  void initialise();

  static final ServiceLocator ttnflixServiceLocator = ServiceLocatorImpl();

  bool isRegistered<T extends Object>({Object? instance, String? instanceName});

  void registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  });

  void registerLazySingletonAsync<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  });

  void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
    DisposingFunc<T>? dispose,
  });

  void registerSingletonWithDependencies<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    Iterable<Type>? dependsOn,
    bool? signalsReady,
    DisposingFunc<T>? dispose,
  });

  T get<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  });

  Future<T> getAsync<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  });

  Future<void> isReady<T extends Object>({
    Object? instance,
    String? instanceName,
    Duration? timeout,
    Object? callee,
  });

  bool isReadySync<T extends Object>({
    Object? instance,
    String? instanceName,
  });
}

class SL {
  static T get<T extends Object>([T? instance]) {
    return instance ?? ServiceLocator.ttnflixServiceLocator.get<T>();
  }
}
