
import 'package:uni_link/features/domain/repositories/firebase_repository.dart';

import '../../../entities/comment/comment_entity.dart';

class DeleteCommentUseCase {
  final FirebaseRepository repository;

  DeleteCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.deleteComment(comment);
  }
}