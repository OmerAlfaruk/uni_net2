

import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uni_link/features/news/domain/repositories/news_repository.dart';
class LikeNewsUseCase {
  final NewsRepository repository;

  LikeNewsUseCase({required this.repository});

  Future<void> call(NewsEntity news) {
    return repository.likeNews(news);
  }
}