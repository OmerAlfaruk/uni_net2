
import 'package:uni_link/features/news/comment/domain/entities/comment_entity.dart';
import 'package:uni_link/features/news/comment/domain/repositories/comment_repository.dart';

class UpdateNewsCommentUseCase {
  final NewsCommentRepository repository;

  UpdateNewsCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.updateComment(comment);
  }
}