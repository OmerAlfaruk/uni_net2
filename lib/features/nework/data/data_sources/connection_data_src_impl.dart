import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/nework/data/data_sources/connection_data_source.dart';
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';
class ConnectionDataSrcImpl implements ConnectionDataSrc{
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  ConnectionDataSrcImpl({required this.firebaseFirestore, required this.firebaseAuth, required this.firebaseStorage});
  @override
  Future<void> followUnFollowUser(UserEntity user) async {

    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    final myDocRef = await userCollection.doc(user.uid).get();
    final otherUserDocRef = await userCollection.doc(user.otherUid).get();

    if (myDocRef.exists && otherUserDocRef.exists) {
      List myFollowingList = myDocRef.get("connections");
      List otherUserFollowersList = otherUserDocRef.get("connections");

      // My Following List
      if (myFollowingList.contains(user.otherUid)) {
        userCollection.doc(user.uid).update({"connections": FieldValue.arrayRemove([user.otherUid])}).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(user.uid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalFollowing = value.get('totalConnection');
              userCollection.update({"totalConnection": totalFollowing - 1});
              return;
            }
          });
        });
      } else {
        userCollection.doc(user.uid).update({"connections": FieldValue.arrayUnion([user.otherUid])}).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(user.uid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalFollowing = value.get('totalConnection');
              userCollection.update({"totalConnection": totalFollowing + 1});
              return;
            }
          });
        });
      }

      // Other User Following List
      if (otherUserFollowersList.contains(user.uid)) {
        userCollection.doc(user.otherUid).update({"connections": FieldValue.arrayRemove([user.uid])}).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(user.otherUid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalFollowers = value.get('totalConnection');
              userCollection.update({"totalConnection": totalFollowers - 1});
              return;
            }
          });
        });
      } else {
        userCollection.doc(user.otherUid).update({"connections": FieldValue.arrayUnion([user.uid])}).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(user.otherUid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalFollowers = value.get('totalConnection');
              userCollection.update({"totalConnection": totalFollowers + 1});
              return;
            }
          });
        });

      }
    }
  }
}