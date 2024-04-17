import 'dart:io';

import 'package:uni_link/features/user/user_entity/user_entity.dart';




abstract class UserRemoteDataSrc {
  // Credential Features
  Future<void> signInUser(UserEntity user);

  Future<void> signUpUser(UserEntity user);

  Future<bool> isSignIn();

  Future<void> signOut();

  // User Features
  Stream<List<UserEntity>> getUsers(UserEntity user);

  Stream<List<UserEntity>> getSingleUser(String uid);

  Future<String> getCurrentUid();

  Future<void> createUser(UserEntity user);

  Future<void> updateUser(UserEntity user);
  // cloud storage
  Future<String> uploadImageToStorage(File? file,bool isPost,String childName);
  Stream<List<UserEntity>> getSingleOtherUser(String otherUid);
}