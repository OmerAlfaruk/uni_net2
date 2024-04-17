part of 'news_cubit.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoading extends NewsState {
  @override
  List<Object> get props => [];
}


class NewsLoaded extends NewsState {
  final List<NewsEntity> news;

  NewsLoaded({required this.news});
  @override
  List<Object> get props => [news];
}


class NewsFailure extends NewsState {
  @override
  List<Object> get props => [];
}
