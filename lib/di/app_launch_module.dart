import 'package:dio/dio.dart';
import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/di/service_locator_impl.dart';
import 'package:ttn_flix/network/ttnflix_dio_service.dart';
import 'package:ttn_flix/network/ttnflix_api_client.dart';


class AppLaunchModule {
  Future<void> initialise() async {
    // Initialise service provider
    ServiceLocatorImpl().initialise();
    final serviceLocator = ServiceLocator.ttnflixServiceLocator;
    /**
     * use serviceLocator to register other dependencies as singleton like
     * if (!serviceLocator.isRegistered<LocalPersistence>()) {
     * serviceLocator.registerSingleton(localPersistence);
     * }
     * */

    // Dio Service
    if (!serviceLocator.isRegistered<TtnflixDioService>()) {
      serviceLocator.registerSingleton(TtnflixDioService(dioClient: Dio()));
    }

    // // Dio Http Client
    if (!serviceLocator.isRegistered<TtnflixApiClient>()) {
      serviceLocator.registerSingleton(TtnflixApiClient());
    }
  }
}
