import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../models/post_model.dart';

typedef AddOrDeleteOrUpdate = Future<Unit> Function();

class PostRepositoryImp implements PostRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const PostRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        final List<PostModel> remotePosts = await remoteDataSource
            .getAllPosts();
        await localDataSource.cachePost(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final List<PostModel> localPosts = await localDataSource
            .getCachedPosts();
        return Right(localPosts);
      } on CacheEmptyException {
        return Left(CacheEmptyFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(title: post.title, body: post.body);
    return await _checkInternetOnAddOrDeleteOrUpdate(
      () async => await remoteDataSource.addPost(postModel),
    );
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _checkInternetOnAddOrDeleteOrUpdate(
      () async => await remoteDataSource.deletePost(id),
    );
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _checkInternetOnAddOrDeleteOrUpdate(
      () async => await remoteDataSource.updatePost(postModel),
    );
  }

  Future<Either<Failure, Unit>> _checkInternetOnAddOrDeleteOrUpdate(
    AddOrDeleteOrUpdate addOrDeleteOrUpdate,
  ) async {
    if (await networkInfo.isConnectedToInternet) {
      try {
        await addOrDeleteOrUpdate();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
