

import 'package:uni_link/features/news/comment/domain/entities/comment_entity.dart';

abstract class NewsCommentRemoteDataSrc{
  Future<void> createComment(CommentEntity comment);
  Stream<List<CommentEntity>> readComments(String newsId);
  Future<void> updateComment(CommentEntity comment);
  Future<void> deleteComment(CommentEntity comment);
  Future<void> likeComment(CommentEntity comment);
}