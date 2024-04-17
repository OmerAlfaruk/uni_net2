import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';


class AnnouncementsModel extends AnnouncementsEntity {

  final String? announcementsId;
  final String? creatorUid;
  final String? username;
  final String?announcementsType;
  final String? description;
  final String? announcementsImageUrl;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalComments;
  final Timestamp? createAt;
  final String? userProfileUrl;

  AnnouncementsModel({this.announcementsId,
    this.announcementsType,
    this.creatorUid,
    this.username,
    this.description,
    this.announcementsImageUrl,
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
    announcementsId: announcementsId,
    announcementsType: announcementsType,
    announcementsImageUrl: announcementsImageUrl,
    totalComments: totalComments,
    totalLikes: totalLikes,
    username: username,
    userProfileUrl: userProfileUrl,
  );

  factory AnnouncementsModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return AnnouncementsModel(
      createAt: snapshot['createAt'],
      creatorUid: snapshot['creatorUid'],
      description: snapshot['description'],
      announcementsType: snapshot['announcementsType'],
      userProfileUrl: snapshot['userProfileUrl'],
      totalLikes: snapshot['totalLikes'],
      totalComments: snapshot['totalComments'],
      announcementsImageUrl: snapshot['announcementsImageUrl'],
      announcementsId: snapshot['announcementsId'],
      username: snapshot['username'],
      likes: List.from(snap.get("likes")),
    );
  }

  Map<String, dynamic> toJson() => {
    "createAt": createAt,
    "creatorUid": creatorUid,
    "description": description,
    "announcementsType":announcementsType,
    "userProfileUrl": userProfileUrl,
    "totalLikes": totalLikes,
    "totalComments": totalComments,
    "announcementsImageUrl": announcementsImageUrl,
    "announcementsId": announcementsId,
    "likes": likes,
    "username": username,
  };}