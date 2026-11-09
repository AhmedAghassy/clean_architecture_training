import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/error_messages.dart';
import '../../../../../core/strings/seccessfully_messages.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';

part 'posts_modify_event.dart';
part 'posts_modify_state.dart';

typedef EitherAddOrDeleteOrUpdate = Either<Failure, Unit>;

class PostsModifyBloc extends Bloc<PostsModifyEvent, PostsModifyState> {
  final AddPost addPost;
  final DeletePost deletePost;
  final UpdatePost updatePost;

  PostsModifyBloc({
    required this.addPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(InitialAddOrDeleteOrUpdateStateState()) {
    on<PostsModifyEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddOrDeleteOrUpdateStateState());
        final failureOrDone = await addPost(event.post);
        emit(
          _eitherFailureOrDoneOnAddOrDeleteOrUpdate(
            failureOrDone,
            addSuccessfullyMessage,
          ),
        );
      } else if (event is DeletePostEvent) {
        emit(LoadingAddOrDeleteOrUpdateStateState());
        final failureOrDone = await deletePost(event.id);
        emit(
          _eitherFailureOrDoneOnAddOrDeleteOrUpdate(
            failureOrDone,
            deleteSuccessfullyMessage,
          ),
        );
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddOrDeleteOrUpdateStateState());
        final failureOrDone = await updatePost(event.post);
        emit(
          _eitherFailureOrDoneOnAddOrDeleteOrUpdate(
            failureOrDone,
            updateSuccessfullyMessage,
          ),
        );
      }
    });
  }

  PostsModifyState _eitherFailureOrDoneOnAddOrDeleteOrUpdate(
    EitherAddOrDeleteOrUpdate either,
    String successMessage,
  ) {
    return either.fold(
      (failure) {
        return ErrorAddOrDeleteOrUpdateState(
          errorMessage: _getErrorMessage(failure),
        );
      },
      (_) {
        return SuccessAddOrDeleteOrUpdateState(successMessage: successMessage);
      },
    );
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure _:
        return offlineFailureMessage;
      case ServerFailure _:
        return serverFailureMessage;
      default:
        return unexpectedFailureMessage;
    }
  }
}
