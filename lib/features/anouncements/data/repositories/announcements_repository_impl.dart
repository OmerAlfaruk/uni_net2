import 'dart:io';

import 'package:uni_link/features/anouncements/data/data_sources/announcement_remote_data_src.dart';
import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';
import 'package:uni_link/features/anouncements/domain/repositories/announcement_repository.dart';
import 'package:uni_link/features/news/data/data_sources/post_remote_data_src.dart';
import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uni_link/features/news/domain/repositories/news_repository.dart';
import 'package:uni_link/features/post/data/data_sources/post_remote_data_src.dart';
import 'package:uni_link/features/post/domain/entities/post_entity.dart';
import 'package:uni_link/features/post/domain/repositories/post_repository.dart';

class AnnouncementsRepositoryImpl implements AnnouncementRepository{
  final AnnouncementsRemoteDataSrc remoteDataSource;

  AnnouncementsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createAnnouncements(AnnouncementsEntity news) async => remoteDataSource.createAnnouncements(news);
  @override
  Future<void> deleteAnnouncements(AnnouncementsEntity news) async => remoteDataSource.deleteAnnouncements(news);

  @override
  Future<void> likeAnnouncements(AnnouncementsEntity news) async => remoteDataSource.likeAnnouncements(news);

  @override
  Stream<List<AnnouncementsEntity>> readAnnouncements(AnnouncementsEntity news) => remoteDataSource.readAnnouncements(news);

  @override
  Future<void> updateAnnouncements(AnnouncementsEntity news) async => remoteDataSource.updateAnnouncements(news);

  @override
  Stream<List<AnnouncementsEntity>> readSingleAnnouncements(String newsId) => remoteDataSource.readSingleAnnouncements(newsId);

  @override
  Future<String> uploadImageToStorage1(File? file, bool isAnnouncements, String childName) async =>
      remoteDataSource.uploadImageToStorage1(file, isAnnouncements, childName);


}