import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetAllPosts {
  final PostRepository postRepository;

  const GetAllPosts({required this.postRepository});

  Future<Either<Failure, List<Post>>> call() async {
    return await postRepository.getAllPosts();
  }
}
