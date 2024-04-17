

import 'package:uni_link/features/news/comment/data/data_sources/comment_remote_data_src.dart';
import 'package:uni_link/features/news/comment/domain/entities/comment_entity.dart';
import 'package:uni_link/features/news/comment/domain/repositories/comment_repository.dart';

class NewsCommentRepositoryImpl implements NewsCommentRepository{
  final NewsCommentRemoteDataSrc remoteDataSource;

  NewsCommentRepositoryImpl({required this.remoteDataSource});
  Future<void> createComment(CommentEntity comment) async => remoteDataSource.createComment(comment);

  @override
  Future<void> deleteComment(CommentEntity comment) async => remoteDataSource.deleteComment(comment);

  @override
  Future<void> likeComment(CommentEntity comment) async => remoteDataSource.likeComment(comment);

  @override
  Stream<List<CommentEntity>> readComments(String newsId) => remoteDataSource.readComments(newsId);

  @override
  Future<void> updateComment(CommentEntity comment) async => remoteDataSource.updateComment(comment);



}