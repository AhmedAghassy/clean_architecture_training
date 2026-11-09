import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class AddPost {
  final PostRepository postRepository;

  const AddPost({required this.postRepository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postRepository.addPost(post);
  }
}
