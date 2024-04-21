

import 'package:uni_link/features/post/domain/entities/post_entity.dart';

import 'package:uni_link/features/post/domain/repositories/post_repository.dart';

class LikePostUseCase {
  final PostRepository repository;

  LikePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.likePost(post);
  }
}