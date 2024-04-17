import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AnnouncementsEntity extends Equatable {
  final String? announcementsId;
 final String? announcementsType;
  final String? creatorUid;
  final String? username;
  final String? description;
  final String? announcementsImageUrl;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalComments;
  final Timestamp? createAt;
  final String? userProfileUrl;

  AnnouncementsEntity({
    this.announcementsType,
    this.announcementsId,
    this.creatorUid,
    this.username,
    this.description,
    this.announcementsImageUrl,
    this.likes,
    this.totalLikes,
    this.totalComments,
    this.createAt,
    this.userProfileUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    announcementsType,
    announcementsId,
    creatorUid,
    username,
    description,
    announcementsImageUrl,
    likes,
    totalLikes,
    totalComments,
    createAt,
    userProfileUrl,
  ];
}