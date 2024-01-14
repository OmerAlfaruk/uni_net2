import 'package:uni_link/features/domain/entities/post/post_entity.dart';
import 'package:uni_link/features/domain/repositories/firebase_repository.dart';

import '../../../entities/comment/comment_entity.dart';

class ReadCommentsUseCase {
  final FirebaseRepository repository;

  ReadCommentsUseCase({required this.repository});

  Stream<List<CommentEntity>> call(String postId) {
    return repository.readComments(postId);
  }
}