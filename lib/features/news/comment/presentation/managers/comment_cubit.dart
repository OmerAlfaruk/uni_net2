import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_link/features/news/comment/domain/entities/comment_entity.dart';
import 'package:uni_link/features/news/comment/domain/use_cases/create_comment_usecase.dart';
import 'package:uni_link/features/news/comment/domain/use_cases/delete_comment_usecase.dart';
import 'package:uni_link/features/news/comment/domain/use_cases/like_comment_use_case.dart';
import 'package:uni_link/features/news/comment/domain/use_cases/read_comment_usecase.dart';
import 'package:uni_link/features/news/comment/domain/use_cases/update_comment_usecase.dart';

part 'comment_state.dart';

class NewsCommentCubit extends Cubit<NewsCommentState> {
  final CreateNewsCommentUseCase createCommentUseCase;
  final DeleteNewsCommentUseCase deleteCommentUseCase;
  final LikeNewsCommentUseCase likeCommentUseCase;
  final ReadNewsCommentsUseCase readCommentsUseCase;
  final UpdateNewsCommentUseCase updateCommentUseCase;
  NewsCommentCubit({
    required this.updateCommentUseCase,
    required this.readCommentsUseCase,
    required this.likeCommentUseCase,
    required this.deleteCommentUseCase,
    required this.createCommentUseCase
  }) : super(CommentInitial());

  Future<void> getComments({required String newsId}) async {
    emit(CommentLoading());
    try {
      final streamResponse = readCommentsUseCase.call(newsId);
      streamResponse.listen((comments) {
        emit(CommentLoaded(comments: comments));
      });
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> likeComment({required CommentEntity comment}) async {
    try {
      await likeCommentUseCase.call(comment);
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> deleteComment({required CommentEntity comment}) async {
    try {
      await deleteCommentUseCase.call(comment);
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> createComment({required CommentEntity comment}) async {
    try {
      await createCommentUseCase.call(comment);
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> updateComment({required CommentEntity comment}) async {
    try {
      await updateCommentUseCase.call(comment);
    } on SocketException catch(_) {
      emit(CommentFailure());
    } catch (_) {
      emit(CommentFailure());
    }
  }
}
