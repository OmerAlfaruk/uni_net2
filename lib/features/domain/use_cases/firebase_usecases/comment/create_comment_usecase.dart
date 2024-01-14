
import 'package:uni_link/features/domain/repositories/firebase_repository.dart';

import '../../../entities/comment/comment_entity.dart';

class CreateCommentUseCase {
  final FirebaseRepository repository;

  CreateCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.createComment(comment);
  }
}