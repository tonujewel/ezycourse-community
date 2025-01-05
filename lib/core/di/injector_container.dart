import 'package:get_it/get_it.dart';

import '../../features/authentication/authentication.dart';
import '../../features/create_post/data/datasources/create_post_datasources.dart';
import '../../features/create_post/data/repositories/create_post_repository_impl.dart';
import '../../features/create_post/domain/repositories/create_post_repository.dart';
import '../../features/create_post/domain/usecases/create_post_usecases.dart';
import '../../features/feed_screen/data/datasources/feed_remote_data_src.dart';
import '../../features/feed_screen/data/repositories/feed_repository_impl.dart';
import '../../features/feed_screen/domain/repositories/feed_repository.dart';
import '../../features/feed_screen/domain/usecases/get_feed_usecases.dart';
import '../../features/feed_screen/domain/usecases/submit_reac_usecases.dart';
import '../networking/dio_client.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  // DIO CLIENT
  getIt.registerLazySingleton(() => DioClient());

  // DATA SOURCES
  getIt.registerLazySingleton<LoginRemoteDatasources>(() => LoginRemoteDatasourcesImpl(client: getIt()));
  getIt.registerLazySingleton<FeedRemoteDataSrc>(() => FeedRemoteDataSrcImpl(dioClient: getIt()));
  getIt.registerLazySingleton<CreatePostDatasources>(() => CreatePostDataSourceImpl(dioClient: getIt()));

  // REPOSITORIES
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositorieyImpl(datasources: getIt()));
  getIt.registerLazySingleton<FeedRepository>(() => FeedRepositoryImpl(dataSrc: getIt()));
  getIt.registerLazySingleton<CreatePostRepository>(() => CreatePostRepositoryImpl(dataSource: getIt()));

  // USECASES
  getIt.registerLazySingleton(() => LoginUsecases(repository: getIt()));
  getIt.registerLazySingleton(() => GetFeedUsecases(repository: getIt()));
  getIt.registerLazySingleton(() => LogoutUsecases(repository: getIt()));
  getIt.registerLazySingleton(() => SubmitReacUsecases(repository: getIt()));
  getIt.registerLazySingleton(() => CreatePostUsecases(repository: getIt()));
}
