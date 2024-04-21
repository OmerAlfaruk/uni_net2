import 'dart:io';
import 'package:uni_link/features/anouncements/domain/repositories/announcement_repository.dart';




class UploadImageToStorageUseCase2 {
   final AnnouncementRepository repository;

  UploadImageToStorageUseCase2({required this.repository});

  Future<String> call(File file, bool isAnnouncement, String childName) {
    return repository.uploadImageToStorage1(file, isAnnouncement, childName);
  }
}