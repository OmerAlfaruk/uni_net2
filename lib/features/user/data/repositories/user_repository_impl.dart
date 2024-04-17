import 'dart:io';

import 'package:uni_link/features/user/data/data_sources/user_remote_data_src.dart';
import 'package:uni_link/features/user/domain/repositories/user_repository.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSrc remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createUser(UserEntity user) async =>
      remoteDataSource.createUser(user);

  @override
  Future<String> getCurrentUid() async => remoteDataSource.getCurrentUid();

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) =>
      remoteDataSource.getSingleUser(uid);

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) =>
      remoteDataSource.getUsers(user);

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signInUser(UserEntity user) async =>
      remoteDataSource.signInUser(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUpUser(UserEntity user) async =>
      remoteDataSource.signUpUser(user);

  @override
  Future<void> updateUser(UserEntity user) async =>
      remoteDataSource.updateUser(user);

  @override
  Future<String> uploadImageToStorage(File? file, bool isPost,
      String childName) async =>
      remoteDataSource.uploadImageToStorage(file, isPost, childName);

  @override
  Stream<List<UserEntity>> getSingleOtherUser(String otherUid)  =>
      remoteDataSource.getSingleOtherUser(otherUid);
}