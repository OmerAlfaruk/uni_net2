
import 'package:uni_link/features/news/comment/domain/entities/comment_entity.dart';
import 'package:uni_link/features/news/comment/domain/repositories/comment_repository.dart';

class ReadNewsCommentsUseCase {
  final NewsCommentRepository repository;

  ReadNewsCommentsUseCase({required this.repository});

  Stream<List<CommentEntity>> call(String newsId) {
    return repository.readComments(newsId);
  }
}