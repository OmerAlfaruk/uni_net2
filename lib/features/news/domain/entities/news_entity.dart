import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final String? newsId;
 final String? newsType;
  final String? creatorUid;
  final String? username;
  final String? description;
  final String? newsImageUrl;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalComments;
  final Timestamp? createAt;
  final String? userProfileUrl;

  NewsEntity({
    this.newsType,
    this.newsId,
    this.creatorUid,
    this.username,
    this.description,
    this.newsImageUrl,
    this.likes,
    this.totalLikes,
    this.totalComments,
    this.createAt,
    this.userProfileUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    newsType,
    newsId,
    creatorUid,
    username,
    description,
    newsImageUrl,
    likes,
    totalLikes,
    totalComments,
    createAt,
    userProfileUrl,
  ];
}