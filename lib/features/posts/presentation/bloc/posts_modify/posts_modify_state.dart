part of 'posts_modify_bloc.dart';

abstract class PostsModifyState extends Equatable {}

class InitialAddOrDeleteOrUpdateStateState extends PostsModifyState {
  @override
  List<Object?> get props => [];
}

class LoadingAddOrDeleteOrUpdateStateState extends PostsModifyState {
  @override
  List<Object?> get props => [];
}

class SuccessAddOrDeleteOrUpdateState extends PostsModifyState {
  final String successMessage;

  SuccessAddOrDeleteOrUpdateState({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class ErrorAddOrDeleteOrUpdateState extends PostsModifyState {
  final String errorMessage;

  ErrorAddOrDeleteOrUpdateState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
