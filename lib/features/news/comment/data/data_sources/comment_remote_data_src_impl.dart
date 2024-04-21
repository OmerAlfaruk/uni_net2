import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/news/comment/data/data_sources/comment_remote_data_src.dart';
import 'package:uni_link/features/news/comment/data/models/comment_model.dart';
import 'package:uni_link/features/news/comment/domain/entities/comment_entity.dart';


class NewsCommentRemoteDataSrcImp implements NewsCommentRemoteDataSrc{
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  NewsCommentRemoteDataSrcImp({required this.firebaseFirestore, required this.firebaseAuth, required this.firebaseStorage});
  @override
  Future<void> createComment(CommentEntity comment) async {
    final commentCollection = firebaseFirestore.collection(FirebaseConst.news).doc(comment.newsId).collection(FirebaseConst.comment);

    final newComment = CommentModel(
        userProfileUrl: comment.userProfileUrl,
        username: comment.username,
        totalReplays: comment.totalReplays,
        commentId: comment.commentId,
        newsId: comment.newsId,
        likes: [],
        description: comment.description,
        creatorUid: comment.creatorUid,
        createAt: comment.createAt
    ).toJson();

    try {

      final commentDocRef = await commentCollection.doc(comment.commentId).get();

      if (!commentDocRef.exists) {
        commentCollection.doc(comment.commentId).set(newComment).then((value) {

          final newsCollection = firebaseFirestore.collection(FirebaseConst.news).doc(comment.newsId);

          newsCollection.get().then((value) {
            if (value.exists) {
              final totalComments = value.get('totalComments');
              newsCollection.update({"totalComments": totalComments + 1});
              return;
            }
          });
        });
      } else {
        commentCollection.doc(comment.commentId).update(newComment);
      }


    } catch (e) {
      print("some error occured $e");
    }

  }

  @override
  Future<void> deleteComment(CommentEntity comment) async {
    final commentCollection = firebaseFirestore.collection(FirebaseConst.news).doc(comment.newsId).collection(FirebaseConst.comment);

    try {
      commentCollection.doc(comment.commentId).delete().then((value) {
        final newsCollection = firebaseFirestore.collection(FirebaseConst.news).doc(comment.newsId);

        newsCollection.get().then((value) {
          if (value.exists) {
            final totalComments = value.get('totalComments');
            newsCollection.update({"totalComments": totalComments - 1});
            return;
          }
        });
      });
    } catch (e) {
      print("some error occured $e");
    }

  }

  @override
  Future<void> likeComment(CommentEntity comment) async {
    final commentCollection = firebaseFirestore.collection(FirebaseConst.news).doc(comment.newsId).collection(FirebaseConst.comment);
    final currentUid = await getCurrentUid();

    final commentRef = await commentCollection.doc(comment.commentId).get();

    if (commentRef.exists) {
      List likes = commentRef.get("likes");
      if (likes.contains(currentUid)) {
        commentCollection.doc(comment.commentId).update({
          "likes": FieldValue.arrayRemove([currentUid])
        });
      } else {
        commentCollection.doc(comment.commentId).update({
          "likes": FieldValue.arrayUnion([currentUid])
        });
      }

    }


  }

  @override
  Stream<List<CommentEntity>> readComments(String newsId) {
    final commentCollection = firebaseFirestore.collection(FirebaseConst.news).doc(newsId).collection(FirebaseConst.comment).orderBy("createAt", descending: true);
    return commentCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => CommentModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateComment(CommentEntity comment) async {
    final commentCollection = firebaseFirestore.collection(FirebaseConst.news).doc(comment.newsId).collection(FirebaseConst.comment);

    Map<String, dynamic> commentInfo = Map();

    if (comment.description != "" && comment.description != null) commentInfo["description"] = comment.description;

    commentCollection.doc(comment.commentId).update(commentInfo);
  }

  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;
}