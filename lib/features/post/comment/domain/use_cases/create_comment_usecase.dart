
import 'package:uni_link/features/post/comment/domain/entities/comment_entity.dart';
import 'package:uni_link/features/post/comment/domain/repositories/comment_repository.dart';

class CreateCommentUseCase {
  final CommentRepository repository;

  CreateCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.createComment(comment);
  }
}