part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {}

class GetAllPostsEvent extends PostsEvent {
  @override
  List<Object?> get props => [];
}

class RefreshPostsEvent extends PostsEvent {
  @override
  List<Object?> get props => [];
}
