import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_link/features/news/comment/replay/domain/entities/replay_entity.dart';



class ReplayModel extends ReplayEntity2 {

  final String? creatorUid;
  final String? replayId;
  final String? commentId;
  final String? newsId;
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final List<String>? likes;
  final Timestamp? createAt;

  ReplayModel({
    this.creatorUid,
    this.replayId,
    this.commentId,
    this.newsId,
    this.description,
    this.username,
    this.userProfileUrl,
    this.likes,
    this.createAt,
  }) : super(
      description: description,
      commentId: commentId,
      newsId: newsId,
      creatorUid: creatorUid,
      userProfileUrl: userProfileUrl,
      username: username,
      likes: likes,
      createAt: createAt,
      replayId: replayId
  );

  factory ReplayModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ReplayModel(
      newsId: snapshot['newsId'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      userProfileUrl: snapshot['userProfileUrl'],
      commentId: snapshot['commentId'],
      replayId: snapshot['replayId'],
      createAt: snapshot['createAt'],
      username: snapshot['username'],
      likes: List.from(snap.get("likes")),
    );
  }

  Map<String, dynamic> toJson() => {
    "creatorUid": creatorUid,
    "description": description,
    "userProfileUrl": userProfileUrl,
    "commentId": commentId,
    "createAt": createAt,
    "replayId": replayId,
    "newsId": newsId,
    "likes": likes,
    "username": username,
  };
}