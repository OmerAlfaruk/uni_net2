import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uni_link/features/post/domain/entities/post_entity.dart';

class NewsModel extends NewsEntity {

  final String? newsId;
  final String? creatorUid;
  final String? username;
  final String?newsType;
  final String? description;
  final String? newsImageUrl;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalComments;
  final Timestamp? createAt;
  final String? userProfileUrl;

  NewsModel({this.newsId,
    this.newsType,
    this.creatorUid,
    this.username,
    this.description,
    this.newsImageUrl,
    this.likes,
    this.totalLikes,
    this.totalComments,
    this.createAt,
    this.userProfileUrl,
  }) : super(
    createAt: createAt,
    creatorUid: creatorUid,
    description: description,
    likes: likes,
    newsId: newsId,
    newsType: newsType,
    newsImageUrl: newsImageUrl,
    totalComments: totalComments,
    totalLikes: totalLikes,
    username: username,
    userProfileUrl: userProfileUrl,
  );

  factory NewsModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return NewsModel(
      createAt: snapshot['createAt'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      newsType: snapshot['newsType'],
      userProfileUrl: snapshot['userProfileUrl'],
      totalLikes: snapshot['totalLikes'],
      totalComments: snapshot['totalComments'],
      newsImageUrl: snapshot['newsImageUrl'],
      newsId: snapshot['newsId'],
      username: snapshot['username'],
      likes: List.from(snap.get("likes")),
    );
  }

  Map<String, dynamic> toJson() => {
    "createAt": createAt,
    "creatorUid": creatorUid,
    "description": description,
    "newsType":newsType,
    "userProfileUrl": userProfileUrl,
    "totalLikes": totalLikes,
    "totalComments": totalComments,
    "newsImageUrl": newsImageUrl,
    "newsId": newsId,
    "likes": likes,
    "username": username,
  };}