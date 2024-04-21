import 'dart:io';

import 'package:uni_link/features/news/domain/entities/news_entity.dart';


abstract class NewsRemoteDataSrc{

  // News Features
  Future<void> createNews(NewsEntity news);

  Stream<List<NewsEntity>> readNews(NewsEntity news);

  Stream<List<NewsEntity>> readSingleNews(String newsId);

  Future<void> updateNews(NewsEntity news);

  Future<void> deleteNews(NewsEntity news);

  Future<void> likeNews(NewsEntity news);
  Future<String> uploadImageToStorage1(File? file, bool isNews, String childName);
}