import 'dart:io';

import 'package:uni_link/features/news/data/data_sources/post_remote_data_src.dart';
import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uni_link/features/news/domain/repositories/news_repository.dart';
import 'package:uni_link/features/post/data/data_sources/post_remote_data_src.dart';
import 'package:uni_link/features/post/domain/entities/post_entity.dart';
import 'package:uni_link/features/post/domain/repositories/post_repository.dart';

class NewsRepositoryImpl implements NewsRepository{
  final NewsRemoteDataSrc remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createNews(NewsEntity news) async => remoteDataSource.createNews(news);
  @override
  Future<void> deleteNews(NewsEntity news) async => remoteDataSource.deleteNews(news);

  @override
  Future<void> likeNews(NewsEntity news) async => remoteDataSource.likeNews(news);

  @override
  Stream<List<NewsEntity>> readNews(NewsEntity news) => remoteDataSource.readNews(news);

  @override
  Future<void> updateNews(NewsEntity news) async => remoteDataSource.updateNews(news);

  @override
  Stream<List<NewsEntity>> readSingleNews(String newsId) => remoteDataSource.readSingleNews(newsId);

  @override
  Future<String> uploadImageToStorage1(File? file, bool isNews, String childName) async =>
      remoteDataSource.uploadImageToStorage1(file, isNews, childName);


}