part of 'posts_modify_bloc.dart';

abstract class PostsModifyEvent extends Equatable {}

class AddPostEvent extends PostsModifyEvent {
  final Post post;

  AddPostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}

class DeletePostEvent extends PostsModifyEvent {
  final int id;

  DeletePostEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdatePostEvent extends PostsModifyEvent {
  final Post post;

  UpdatePostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}
