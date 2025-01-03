import 'package:ezycourse_community/features/authentication/authentication.dart';

import '../networking/dio_client.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // DIO CLIENT
  getIt.registerLazySingleton(() => DioClient());

  // USECASES
  getIt.registerLazySingleton(() => LoginUsecases(repositories: getIt()));

  // DATA SOURCES

  getIt.registerLazySingleton<LoginRemoteDatasources>(() => LoginRemoteDatasourcesImpl(client: getIt()));

  // REPOSITORIES
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositorieyImpl(datasources: getIt()));

  //
}
