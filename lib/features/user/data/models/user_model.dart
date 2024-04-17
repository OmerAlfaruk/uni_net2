import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';


class UserModel extends UserEntity {
  final String? uid;
  final bool? isOnline;
  final String? username;
  final String? name;
  final String? bio;
  final String? university;
  final String? website;
  final String? email;
  final String? profileUrl;
  final List? connections;
  final num? totalConnection;
  final num? totalPosts;
  final String? department;
  final String? privilege;

  UserModel( {
    this.department,
    this.privilege,
    this.isOnline,
    this.uid,
    this.username,
    this.name,
    this.bio,
    this.university,
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
    isOnline: isOnline,
    website: website,
    department: department,
    privilege: privilege,
    connections: connections,
    bio: bio,
    university:university,
    email: email,
    totalPosts: totalPosts,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      email: snapshot['email'],
      name: snapshot['name'],
      bio: snapshot['bio'],
      isOnline: snapshot['isOnline'],
      department: snapshot['department'],
      privilege: snapshot['privilege'],
      username: snapshot['username'],
      totalConnection: snapshot['totalConnection'],
      totalPosts: snapshot['totalPosts'],
      uid: snapshot['uid'],
      university:snapshot['university'],
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
    "isOnline": isOnline,
    "totalConnection": totalConnection,
    "totalPosts": totalPosts,
    "website": website,
    "bio": bio,
    "privilege":privilege,
    "department":department,
    "university":university,
    "profileUrl": profileUrl,
    "connections": connections,
  };
}
