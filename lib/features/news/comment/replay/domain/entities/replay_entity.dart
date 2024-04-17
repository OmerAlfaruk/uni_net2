import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ReplayEntity2 extends Equatable {
  final String? creatorUid;
  final String? replayId;
  final String? commentId;
  final String? newsId;
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final List<String>? likes;
  final Timestamp? createAt;

  ReplayEntity2({
    this.creatorUid,
    this.replayId,
    this.commentId,
    this.newsId,
    this.description,
    this.username,
    this.userProfileUrl,
    this.likes,
    this.createAt,
  });

  @override
  List<Object?> get props => [
    creatorUid,
    replayId,
    commentId,
    newsId,
    description,
    username,
    userProfileUrl,
    likes,
    createAt,
  ];
}
