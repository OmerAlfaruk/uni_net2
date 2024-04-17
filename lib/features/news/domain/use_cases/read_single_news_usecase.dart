
import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uni_link/features/news/domain/repositories/news_repository.dart';

class ReadSingleNewsUseCase {
  final NewsRepository repository;

  ReadSingleNewsUseCase({required this.repository});

  Stream<List<NewsEntity>> call(String newsId) {
    return repository.readSingleNews(newsId);
  }
}