import 'dart:io';

import 'package:uni_link/features/app/domain/repositories/firebase_repository.dart';
import 'package:uni_link/features/post/domain/repositories/post_repository.dart';



class UploadImageToStorageUseCase {
   final PostRepository repository;

  UploadImageToStorageUseCase({required this.repository});

  Future<String> call(File file, bool isPost, String childName) {
    return repository.uploadImageToStorage(file, isPost, childName);
  }
}