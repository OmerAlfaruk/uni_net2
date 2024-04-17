
import 'package:uni_link/features/post/comment/domain/entities/comment_entity.dart';
import 'package:uni_link/features/post/comment/domain/repositories/comment_repository.dart';
import 'package:uni_link/features/post/domain/entities/post_entity.dart';



class LikeCommentUseCase {
  final CommentRepository repository;

  LikeCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.likeComment(comment);
  }
}