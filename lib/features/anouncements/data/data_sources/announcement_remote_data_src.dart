import 'dart:io';
import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';
abstract class AnnouncementsRemoteDataSrc{

  // News Features
  Future<void> createAnnouncements(AnnouncementsEntity announcements);

  Stream<List<AnnouncementsEntity>> readAnnouncements(AnnouncementsEntity announcements);

  Stream<List<AnnouncementsEntity>> readSingleAnnouncements(String announcementsId);

  Future<void> updateAnnouncements(AnnouncementsEntity announcements);

  Future<void> deleteAnnouncements(AnnouncementsEntity announcements);

  Future<void> likeAnnouncements(AnnouncementsEntity announcements);

  // Cloud Storage Feature
  Future<String> uploadImageToStorage1(File? file, bool isAnnouncements, String childName);
}