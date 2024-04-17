part of 'comment_cubit.dart';


abstract class NewsCommentState extends Equatable {
  const NewsCommentState();
}

class CommentInitial extends NewsCommentState {
  @override
  List<Object> get props => [];
}
class CommentLoading extends NewsCommentState {
  @override
  List<Object> get props => [];
}

class CommentLoaded extends NewsCommentState {
  final List<CommentEntity> comments;

  CommentLoaded({required this.comments});
  @override
  List<Object> get props => [comments];
}

class CommentFailure extends NewsCommentState {
  @override
  List<Object> get props => [];
}
