import 'package:uni_link/features/post/comment/domain/entities/comment_entity.dart';
import 'package:uni_link/features/post/comment/domain/repositories/comment_repository.dart';
import 'package:uni_link/features/post/domain/entities/post_entity.dart';




class ReadCommentsUseCase {
  final CommentRepository repository;

  ReadCommentsUseCase({required this.repository});

  Stream<List<CommentEntity>> call(String postId) {
    return repository.readComments(postId);
  }
}