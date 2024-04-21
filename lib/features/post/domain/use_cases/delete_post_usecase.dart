

import 'package:uni_link/features/post/domain/entities/post_entity.dart';
import 'package:uni_link/features/post/domain/repositories/post_repository.dart';

class DeletePostUseCase {
  final PostRepository repository;

  DeletePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.deletePost(post);
  }
}