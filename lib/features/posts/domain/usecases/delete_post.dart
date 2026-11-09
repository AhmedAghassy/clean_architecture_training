import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/post_repository.dart';

class DeletePost {
  final PostRepository postRepository;

  const DeletePost({required this.postRepository});

  Future<Either<Failure, Unit>> call(int id) async {
    return await postRepository.deletePost(id);
  }
}
