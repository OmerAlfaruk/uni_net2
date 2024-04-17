import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/news/comment/replay/data/data_sources/replay_remote_data_src.dart';
import 'package:uni_link/features/news/comment/replay/data/models/replay_model.dart';
import 'package:uni_link/features/news/comment/replay/domain/entities/replay_entity.dart';


class NewsReplayRemoteDataSrcImpl implements NewsReplayRemoteDataSrc{
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  NewsReplayRemoteDataSrcImpl({required this.firebaseFirestore, required this.firebaseAuth, required this.firebaseStorage});
  @override
  Future<void> createReplay(ReplayEntity2 replay) async {
    final replayCollection = firebaseFirestore.collection(FirebaseConst.news).doc(replay.newsId).collection(FirebaseConst.comment).doc(replay.commentId).collection(FirebaseConst.replay);

    final newReplay = ReplayModel(
        userProfileUrl: replay.userProfileUrl,
        username: replay.username,
        replayId: replay.replayId,
        commentId: replay.commentId,
        newsId: replay.newsId,
        likes: [],
        description: replay.description,
        creatorUid: replay.creatorUid,
        createAt: replay.createAt
    ).toJson();


    try {

      final replayDocRef = await replayCollection.doc(replay.replayId).get();

      if (!replayDocRef.exists) {
        replayCollection.doc(replay.replayId).set(newReplay).then((value) {
          final commentCollection = firebaseFirestore.collection(FirebaseConst.news).doc(replay.newsId).collection(FirebaseConst.comment).doc(replay.commentId);

          commentCollection.get().then((value) {
            if (value.exists) {
              final totalReplays = value.get('totalReplays');
              commentCollection.update({"totalReplays": totalReplays + 1});
              return;
            }
          });
        });
      } else {
        replayCollection.doc(replay.replayId).update(newReplay);
      }

    } catch (e) {
      print("some error occured $e");
    }

  }

  @override
  Future<void> deleteReplay(ReplayEntity2 replay) async {
    final replayCollection = firebaseFirestore.collection(FirebaseConst.news).doc(replay.newsId).collection(FirebaseConst.comment).doc(replay.commentId).collection(FirebaseConst.replay);

    try {
      replayCollection.doc(replay.replayId).delete().then((value) {
        final commentCollection = firebaseFirestore.collection(FirebaseConst.news).doc(replay.newsId).collection(FirebaseConst.comment).doc(replay.commentId);

        commentCollection.get().then((value) {
          if (value.exists) {
            final totalReplays = value.get('totalReplays');
            commentCollection.update({"totalReplays": totalReplays - 1});
            return;
          }
        });
      });
    } catch(e) {
      print("some error occured $e");
    }
  }

  @override
  Future<void> likeReplay(ReplayEntity2 replay) async {
    final replayCollection = firebaseFirestore.collection(FirebaseConst.news).doc(replay.newsId).collection(FirebaseConst.comment).doc(replay.commentId).collection(FirebaseConst.replay);

    final currentUid = await getCurrentUid();

    final replayRef = await replayCollection.doc(replay.replayId).get();

    if (replayRef.exists) {
      List likes = replayRef.get("likes");
      if (likes.contains(currentUid)) {
        replayCollection.doc(replay.replayId).update({
          "likes": FieldValue.arrayRemove([currentUid])
        });
      } else {
        replayCollection.doc(replay.replayId).update({
          "likes": FieldValue.arrayUnion([currentUid])
        });
      }
    }
  }

  @override
  Stream<List<ReplayEntity2>> readReplays(ReplayEntity2 replay) {
    final replayCollection = firebaseFirestore.collection(FirebaseConst.news).doc(replay.newsId).collection(FirebaseConst.comment).doc(replay.commentId).collection(FirebaseConst.replay);
    return replayCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => ReplayModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateReplay(ReplayEntity2 replay) async {
    final replayCollection = firebaseFirestore.collection(FirebaseConst.news).doc(replay.newsId).collection(FirebaseConst.comment).doc(replay.commentId).collection(FirebaseConst.replay);

    Map<String, dynamic> replayInfo = Map();

    if (replay.description != "" && replay.description != null) replayInfo['description'] = replay.description;

    replayCollection.doc(replay.replayId).update(replayInfo);
  }
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

}