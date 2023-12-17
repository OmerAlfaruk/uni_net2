import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_link/features/domain/entities/user/user_entity.dart';


class UserModel extends UserEntity {
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

  UserModel({
    this.uid,
    this.username,
    this.name,
    this.bio,
    this.website,
    this.email,
    this.profileUrl,
    this.connections,
    this.totalConnection,
    this.totalPosts,
  }) : super(
    uid: uid,
    totalConnection: totalConnection,
    username: username,
    profileUrl: profileUrl,
    website: website,
    connections: connections,
    bio: bio,
    name: name,
    email: email,
    totalPosts: totalPosts,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      email: snapshot['email'],
      name: snapshot['name'],
      bio: snapshot['bio'],
      username: snapshot['username'],
      totalConnection: snapshot['totalConnection'],
      totalPosts: snapshot['totalPosts'],
      uid: snapshot['uid'],
      website: snapshot['website'],
      profileUrl: snapshot['profileUrl'],
      connections: List.from(snap.get("connections")),
    );
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "email": email,
    "name": name,
    "username": username,
    "totalConnection": totalConnection,
    "totalPosts": totalPosts,
    "website": website,
    "bio": bio,
    "profileUrl": profileUrl,
    "connections": connections,
  };
}
