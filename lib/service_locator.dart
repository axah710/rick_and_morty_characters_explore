import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'features/favorites/presentation/managers/cubit/favorites_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/impl/dio_impl/dio_consumer.dart';
import 'core/network/impl/dio_impl/dio_interceptors.dart';
import 'core/utils/debug_prints.dart';
import 'features/home/data/data_source/home_remote_data_source.dart';
import 'features/home/data/home_repo_imp/home_repo_imp.dart';
import 'features/home/domain/home_repo/home_repo.dart';
import 'features/home/domain/home_use_case/home_use_case.dart';
import 'features/home/presentation/managers/home_cubit/home_cubit.dart';

class ServiceLocator {
  static final GetIt getIt = GetIt.instance;
  static final ServiceLocator _instance = ServiceLocator._internal();

  ServiceLocator._internal();

  factory ServiceLocator() => _instance;

  Future<void> init() async {
    await _registerPreferences();
    _registerNetworkServices();
    _setupHomeServiceLocator();
    _setupFavoritesServiceLocator();
    Logger.printInfo("All services registered.");
  }

  Future<void> _registerPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => preferences);
  }

  void _registerNetworkServices() {
    _registerDio();
    _registerDioInterceptors();
    _registerDioConsumer();
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

  void _setupHomeServiceLocator() {
    getIt.registerLazySingleton<HomeRemoteDataSource>(
      () => CharactersRemoteDataSourceImpl(
        dioConsumer: getIt<DioConsumer>(),
      ),
    );
    getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: getIt<HomeRemoteDataSource>()),
    );
    getIt.registerLazySingleton<HomeUseCase>(
      () => HomeUseCase(repository: getIt<HomeRepository>()),
    );
    getIt.registerLazySingleton<HomeCubit>(
      () => HomeCubit(homeUseCase: getIt<HomeUseCase>()),
    );
  }

  void _setupFavoritesServiceLocator() {
    getIt.registerLazySingleton<FavoritesCubit>(
      () => FavoritesCubit(),
    );
  }

  FavoritesCubit get favoritesCubit => getIt<FavoritesCubit>();
  HomeCubit get homeCubit => getIt<HomeCubit>();
}
