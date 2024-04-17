import 'dart:io';
import 'package:uni_link/features/news/domain/repositories/news_repository.dart';



class UploadImageToStorageUseCase1 {
   final NewsRepository repository;

  UploadImageToStorageUseCase1({required this.repository});

  Future<String> call(File file, bool isNews, String childName) {
    return repository.uploadImageToStorage1(file, isNews, childName);
  }
}