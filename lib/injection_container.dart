import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/posts/data/datasources/local_data_source.dart';
import 'features/posts/data/datasources/remote_data_source.dart';
import 'features/posts/data/repositories/post_repository_imp.dart';
import 'features/posts/domain/repositories/post_repository.dart';
import 'features/posts/domain/usecases/add_post.dart';
import 'features/posts/domain/usecases/delete_post.dart';
import 'features/posts/domain/usecases/get_all_posts.dart';
import 'features/posts/domain/usecases/update_post.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'features/posts/presentation/bloc/posts_modify/posts_modify_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //1. core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpInternetConnectionChecker(
      internetConnectionChecker: sl(),
    ),
  );

  //2. features - posts
  //2.1. data
  //2.1.1. datasources
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpSharedPreferences(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpHTTP(client: sl()),
  );

  //2.1.2. repositories
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImp(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //2.2. domain
  //2.2.1. usecases
  sl.registerLazySingleton<AddPost>(() => AddPost(postRepository: sl()));
  sl.registerLazySingleton<DeletePost>(() => DeletePost(postRepository: sl()));
  sl.registerLazySingleton<GetAllPosts>(
    () => GetAllPosts(postRepository: sl()),
  );
  sl.registerLazySingleton<UpdatePost>(() => UpdatePost(postRepository: sl()));

  //2.3. presentation
  //2.3.1. bloc
  sl.registerFactory<PostsBloc>(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory<PostsModifyBloc>(
    () => PostsModifyBloc(addPost: sl(), deletePost: sl(), updatePost: sl()),
  );

  //3. external
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<http.Client>(() => http.Client());
}
