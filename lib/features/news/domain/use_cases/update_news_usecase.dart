
import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uni_link/features/news/domain/repositories/news_repository.dart';


class UpdateNewsUseCase {
  final NewsRepository repository;

  UpdateNewsUseCase({required this.repository});

  Future<void> call(NewsEntity news) {
    return repository.updateNews(news);
  }
}