import 'dart:io';

import 'package:uni_link/features/post/domain/entities/post_entity.dart';

abstract class PostRepository {

  // Post Features
  Future<void> createPost(PostEntity post);

  Stream<List<PostEntity>> readPosts(PostEntity post);

  Stream<List<PostEntity>> readSinglePost(String postId);

  Future<void> updatePost(PostEntity post);

  Future<void> deletePost(PostEntity post);

  Future<void> likePost(PostEntity post);

  // Cloud Storage Feature
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName);
}