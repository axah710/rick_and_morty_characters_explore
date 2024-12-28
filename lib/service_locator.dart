import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/impl/dio_impl/dio_consumer.dart';
import 'core/network/impl/dio_impl/dio_interceptors.dart';
import 'core/utils/debug_prints.dart';

class ServiceLocator {
  static final GetIt getIt = GetIt.instance;
  static final ServiceLocator _instance = ServiceLocator._internal();

  ServiceLocator._internal();

  factory ServiceLocator() => _instance;

  Future<void> init() async {
    await _registerPreferences();
    _registerNetworkServices();
  }

  Future<void> _registerPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => preferences);
  }

  void _registerNetworkServices() {
    _registerDio();
    _registerDioInterceptors();
    _registerDioConsumer();
    Logger.printInfo("All services registered.");
  }

  void _registerDio() {
    getIt.registerLazySingleton<Dio>(() => Dio());
  }

  void _registerDioInterceptors() {
    getIt.registerLazySingleton<DioInterceptor>(() => DioInterceptor());
    getIt.registerLazySingleton<LogInterceptor>(
      () => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ),
    );
  }

  void _registerDioConsumer() {
    getIt.registerLazySingleton<DioConsumer>(
      () => DioConsumer(
        client: getIt<Dio>(),
        dioInterceptor: getIt<DioInterceptor>(),
        logInterceptor: getIt<LogInterceptor>(),
      )..dioInit(),
    );
  }
}
