import 'dart:io';

import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uni_link/features/post/domain/entities/post_entity.dart';

abstract class NewsRepository {

  // Post Features
  Future<void> createNews(NewsEntity news);

  Stream<List<NewsEntity>> readNews(NewsEntity news);

  Stream<List<NewsEntity>> readSingleNews(String newsId);

  Future<void> updateNews(NewsEntity news);

  Future<void> deleteNews(NewsEntity news);

  Future<void> likeNews(NewsEntity news);

  // Cloud Storage Feature
  Future<String> uploadImageToStorage1(File? file, bool isNews, String childName);
}