import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/error_messages.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_all_posts.dart';

part 'posts_event.dart';
part 'posts_state.dart';

typedef EitherAddOrDeleteOrUpdate = Either<Failure, Unit>;

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPosts getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(InitialState()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingState());
        final failureOrPosts = await getAllPosts();
        failureOrPosts.fold(
          (failure) {
            emit(ErrorState(errorMessage: _getErrorMessage(failure)));
          },
          (posts) {
            emit(LoadedState(posts: posts));
          },
        );
      }
    });
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return serverFailureMessage;
      case CacheEmptyFailure _:
        return cacheEmptyFailureMessage;
      default:
        return unexpectedFailureMessage;
    }
  }
}
