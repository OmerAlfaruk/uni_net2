
import 'package:uni_link/features/post/domain/entities/post_entity.dart';

import 'package:uni_link/features/post/domain/repositories/post_repository.dart';

class ReadSinglePostUseCase {
  final PostRepository repository;

  ReadSinglePostUseCase({required this.repository});

  Stream<List<PostEntity>> call(String postId) {
    return repository.readSinglePost(postId);
  }
}