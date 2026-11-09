import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class UpdatePost {
  final PostRepository postRepository;

  const UpdatePost({required this.postRepository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postRepository.updatePost(post);
  }
}
