part of 'get_single_news_cubit.dart';

abstract class GetSingleNewsState extends Equatable {
  const GetSingleNewsState();
}

class GetSingleNewsInitial extends GetSingleNewsState {
  @override
  List<Object> get props => [];
}

class GetSingleNewsLoading extends GetSingleNewsState {
  @override
  List<Object> get props => [];
}


class GetSingleNewsLoaded extends GetSingleNewsState {
  final NewsEntity news;

  GetSingleNewsLoaded({required this.news});
  @override
  List<Object> get props => [news];
}

class GetSingleNewsFailure extends GetSingleNewsState {
  @override
  List<Object> get props => [];
}

