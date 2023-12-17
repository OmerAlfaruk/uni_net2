
import 'dart:io';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? username;
  final String? name;
  final String? bio;
  final String? website;
  final String? email;
  final String? profileUrl;
  final List? connections;
  final num? totalConnection;
  final num? totalPosts;

  // will not going to store in DB
  final File? imageFile;
  final String? password;
  final String? otherUid;

  UserEntity({
    this.imageFile,
    this.uid,
    this.username,
    this.name,
    this.bio,
    this.website,
    this.email,
    this.profileUrl,
    this.connections,
    this.totalConnection,
    this.password,
    this.otherUid,
    this.totalPosts,
  });

  @override
  List<Object?> get props => [
    uid,
    username,
    name,
    bio,
    website,
    email,
    profileUrl,
    connections,
    totalConnection,
    password,
    otherUid,
    totalPosts,
    imageFile
  ];
}
