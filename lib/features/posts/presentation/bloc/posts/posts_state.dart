part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {}

class InitialState extends PostsState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends PostsState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends PostsState {
  final List<Post> posts;

  LoadedState({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class ErrorState extends PostsState {
  final String errorMessage;

  ErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
