
import 'package:uni_link/features/post/comment/domain/entities/comment_entity.dart';

import 'package:uni_link/features/post/comment/domain/repositories/comment_repository.dart';



class DeleteCommentUseCase {
  final CommentRepository repository;

  DeleteCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.deleteComment(comment);
  }
}