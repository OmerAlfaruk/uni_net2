


import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uni_link/features/news/domain/repositories/news_repository.dart';
import 'package:uni_link/features/post/domain/entities/post_entity.dart';
import 'package:uni_link/features/post/domain/repositories/post_repository.dart';

class ReadNewsUseCase {
  final NewsRepository repository;

  ReadNewsUseCase({required this.repository});

  Stream<List<NewsEntity>> call(NewsEntity news) {
    return repository.readNews(news);
  }
}