

import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uni_link/features/news/domain/repositories/news_repository.dart';
import 'package:uni_link/features/post/domain/entities/post_entity.dart';
import 'package:uni_link/features/post/domain/repositories/post_repository.dart';

class DeleteNewsUseCase {
  final NewsRepository repository;

  DeleteNewsUseCase({required this.repository});

  Future<void> call(NewsEntity news) {
    return repository.deleteNews(news);
  }
}