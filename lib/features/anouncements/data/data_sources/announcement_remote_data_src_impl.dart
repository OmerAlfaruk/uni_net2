import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/anouncements/data/data_sources/announcement_remote_data_src.dart';
import 'package:uni_link/features/anouncements/data/models/annoncements_model.dart';

import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';

import 'package:uuid/uuid.dart';

class AnnouncementsRemoteDataSourceImpl implements AnnouncementsRemoteDataSrc{

  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  AnnouncementsRemoteDataSourceImpl( {required this.firebaseFirestore, required this.firebaseAuth,required this.firebaseStorage,});



  @override
  Future<void> createAnnouncements(AnnouncementsEntity announcements) async {
    final announcementsCollection = firebaseFirestore.collection(FirebaseConst.content).doc(FirebaseConst.announcements).collection(FirebaseConst.announcements);

    final newAnnouncements = AnnouncementsModel(
        userProfileUrl: announcements.userProfileUrl,
        username: announcements.username,
        totalLikes: 0,
        totalComments: 0,
       announcementsType: announcements.announcementsType,
        announcementsImageUrl: announcements.announcementsImageUrl,
        announcementsId: announcements.announcementsId,
        likes: [],
        description: announcements.description,
        creatorUid: announcements.creatorUid,
        createAt: announcements.createAt
    ).toJson();

    try {

      final announcementsDocRef = await announcementsCollection.doc(announcements.announcementsId).get();

      if (!announcementsDocRef.exists) {
        announcementsCollection.doc(announcements.announcementsId).set(newAnnouncements).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(announcements.creatorUid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalAnnouncements = value.get('totalAnnouncements');
              userCollection.update({"totalAnnouncements": totalAnnouncements + 1});
              return;
            }
          });
        });
      } else {
        announcementsCollection.doc(announcements.announcementsId).update(newAnnouncements);
      }
    }catch (e) {
      print("some error occured $e");
    }
  }

  @override
  Future<void> deleteAnnouncements( AnnouncementsEntity announcements) async {
    final currentUserId=firebaseAuth.currentUser!.uid;

     final announcementsCollection = firebaseFirestore.collection(FirebaseConst.content).doc(FirebaseConst.announcements).collection(FirebaseConst.announcements);


    try {
      if(announcements.creatorUid==currentUserId){
        announcementsCollection.doc(announcements.announcementsId).delete().then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(announcements.creatorUid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalAnnouncements = value.get('totalAnnouncements');
              userCollection.update({"totalAnnouncements": totalAnnouncements - 1});
              return;
            }
          });
        });
      }else{
        toast("you can't delete this announcements");
      }} catch (e) {
      print("some error occurred $e");
    }
  }

  @override
  Future<void> likeAnnouncements(AnnouncementsEntity announcements) async {
     final announcementsCollection = firebaseFirestore.collection(FirebaseConst.content).doc(FirebaseConst.announcements).collection(FirebaseConst.announcements);

    final currentUid = await getCurrentUid();
    final announcementsRef = await announcementsCollection.doc(announcements.announcementsId).get();

    if (announcementsRef.exists) {
      List likes = announcementsRef.get("likes");
      final totalLikes = announcementsRef.get("totalLikes");
      if (likes.contains(currentUid)) {
        announcementsCollection.doc(announcements.announcementsId).update({
          "likes": FieldValue.arrayRemove([currentUid]),
          "totalLikes": totalLikes - 1
        });
      } else {
        announcementsCollection.doc(announcements.announcementsId).update({
          "likes": FieldValue.arrayUnion([currentUid]),
          "totalLikes": totalLikes + 1
        });
      }
    }
  }

  @override
  Stream<List<AnnouncementsEntity>> readAnnouncements(AnnouncementsEntity announcements) {
    final announcementsCollection = firebaseFirestore.collection(FirebaseConst.content).doc(FirebaseConst.announcements).collection(FirebaseConst.announcements)
.orderBy("createAt", descending: true);
    return announcementsCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => AnnouncementsModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<AnnouncementsEntity>> readSingleAnnouncements(String announcementsId) {
    final announcementsCollection = firebaseFirestore.collection(FirebaseConst.content).doc(FirebaseConst.announcements).collection(FirebaseConst.announcements).
orderBy("createAt", descending: true).where("announcementsId", isEqualTo: announcementsId);
    return announcementsCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => AnnouncementsModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateAnnouncements(AnnouncementsEntity announcements) async {
     final announcementsCollection = firebaseFirestore.collection(FirebaseConst.content).doc(FirebaseConst.announcements).collection(FirebaseConst.announcements);

    Map<String, dynamic> announcementsInfo = Map();

    if (announcements.description != "" && announcements.description != null) announcementsInfo['description'] = announcements.description;
    if (announcements.announcementsImageUrl != "" && announcements.announcementsImageUrl != null) announcementsInfo['announcementsImageUrl'] = announcements.announcementsImageUrl;

    announcementsCollection.doc(announcements.announcementsId).update(announcementsInfo);
  }
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;
  @override
  Future<String> uploadImageToStorage1(File? file, bool isAnnouncements, String childName) async {

    Reference ref = firebaseStorage.ref().child(childName).child(firebaseAuth.currentUser!.uid);

    if (isAnnouncements) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    final uploadTask = ref.putFile(file!);

    final imageUrl = (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }


}