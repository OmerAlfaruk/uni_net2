

import 'dart:io';
import 'package:uni_link/features/domain/repositories/firebase_repository.dart';

class UploadImageToStorageUseCase {
  final FirebaseRepository repository;

  UploadImageToStorageUseCase({required this.repository});

  Future<String> call(File file,bool isPost,String childName) {
    return repository.uploadImageToStorage(file, isPost, childName);
  }
}