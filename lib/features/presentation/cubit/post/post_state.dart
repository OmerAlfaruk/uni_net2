part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {
  @override
  List<Object> get props => [];
}


class PostLoaded extends PostState {
  final List<PostEntity> post;

  PostLoaded({required this.post});
  @override
  List<Object> get props => [post];
}


class PostFailure extends PostState {
  @override
  List<Object> get props => [];
}
