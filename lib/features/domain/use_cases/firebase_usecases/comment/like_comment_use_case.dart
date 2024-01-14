import 'package:uni_link/features/domain/entities/post/post_entity.dart';
import 'package:uni_link/features/domain/repositories/firebase_repository.dart';

import '../../../entities/comment/comment_entity.dart';

class LikeCommentUseCase {
  final FirebaseRepository repository;

  LikeCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.likeComment(comment);
  }
}