




import 'package:uni_link/features/news/comment/domain/entities/comment_entity.dart';
import 'package:uni_link/features/news/comment/domain/repositories/comment_repository.dart';

class LikeNewsCommentUseCase {
  final NewsCommentRepository repository;

  LikeNewsCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.likeComment(comment);
  }
}