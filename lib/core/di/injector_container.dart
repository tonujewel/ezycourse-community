import 'package:get_it/get_it.dart';

import '../../features/authentication/authentication.dart';
import '../../features/feed_screen/data/datasources/feed_remote_data_src.dart';
import '../../features/feed_screen/data/repositories/feed_repository_impl.dart';
import '../../features/feed_screen/domain/repositories/feed_repository.dart';
import '../../features/feed_screen/domain/usecases/get_feed_usecases.dart';
import '../networking/dio_client.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // DIO CLIENT
  getIt.registerLazySingleton(() => DioClient());

  // DATA SOURCES
  getIt.registerLazySingleton<LoginRemoteDatasources>(() => LoginRemoteDatasourcesImpl(client: getIt()));
  getIt.registerLazySingleton<FeedRemoteDataSrc>(() => FeedRemoteDataSrcImpl(dioClient: getIt()));

  // REPOSITORIES
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositorieyImpl(datasources: getIt()));
  getIt.registerLazySingleton<FeedRepository>(() => FeedRepositoryImpl(dataSrc: getIt()));

  // USECASES
  getIt.registerLazySingleton(() => LoginUsecases(repositories: getIt()));
  getIt.registerLazySingleton(() => GetFeedUsecases(repository: getIt()));
}
