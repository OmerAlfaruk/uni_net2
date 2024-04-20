import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/news/data/data_sources/post_remote_data_src.dart';
import 'package:uni_link/features/news/data/models/news_model.dart';
import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uuid/uuid.dart';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSrc{

  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  NewsRemoteDataSourceImpl( {required this.firebaseFirestore, required this.firebaseAuth,required this.firebaseStorage,});



  @override
  Future<void> createNews(NewsEntity news) async {
    final newsCollection = firebaseFirestore.collection(FirebaseConst.content).doc(FirebaseConst.news).collection(FirebaseConst.news);

    final newNews = NewsModel(
        userProfileUrl: news.userProfileUrl,
        username: news.username,
        totalLikes: 0,
        totalComments: 0,
       newsType: news.newsType,
        newsImageUrl: news.newsImageUrl,
        newsId: news.newsId,
        likes: [],
        description: news.description,
        creatorUid: news.creatorUid,
        createAt: news.createAt
    ).toJson();

    try {

      final newsDocRef = await newsCollection.doc(news.newsId).get();

      if (!newsDocRef.exists) {
        newsCollection.doc(news.newsId).set(newNews).then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(news.creatorUid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalNews = value.get('totalNews');
              userCollection.update({"totalNews": totalNews + 1});
              return;
            }
          });
        });
      } else {
        newsCollection.doc(news.newsId).update(newNews);
      }
    }catch (e) {
      print("some error occured $e");
    }
  }

  @override
  Future<void> deleteNews( NewsEntity news) async {
    final currentUserId=firebaseAuth.currentUser!.uid;

    final newsCollection = firebaseFirestore.collection(FirebaseConst.content).doc(FirebaseConst.news).collection(FirebaseConst.news);

    try {
      if(news.creatorUid==currentUserId){
        newsCollection.doc(news.newsId).delete().then((value) {
          final userCollection = firebaseFirestore.collection(FirebaseConst.users).doc(news.creatorUid);

          userCollection.get().then((value) {
            if (value.exists) {
              final totalNews = value.get('totalNews');
              userCollection.update({"totalNews": totalNews - 1});
              return;
            }
          });
        });
      }else{
        toast("you can't delete this news");
      }} catch (e) {
      print("some error occurred $e");
    }
  }

  @override
  Future<void> likeNews(NewsEntity news) async {
    final newsCollection =firebaseFirestore.collection(FirebaseConst.content).doc(FirebaseConst.news).collection(FirebaseConst.news);
    final currentUid = await getCurrentUid();
    final newsRef = await newsCollection.doc(news.newsId).get();

    if (newsRef.exists) {
      List likes = newsRef.get("likes");
      final totalLikes = newsRef.get("totalLikes");
      if (likes.contains(currentUid)) {
        newsCollection.doc(news.newsId).update({
          "likes": FieldValue.arrayRemove([currentUid]),
          "totalLikes": totalLikes - 1
        });
      } else {
        newsCollection.doc(news.newsId).update({
          "likes": FieldValue.arrayUnion([currentUid]),
          "totalLikes": totalLikes + 1
        });
      }
    }
  }

  @override
  Stream<List<NewsEntity>> readNews(NewsEntity news) {
    final newsCollection = firebaseFirestore.collection(FirebaseConst.content).doc(FirebaseConst.news).collection(FirebaseConst.news).orderBy("createAt", descending: true);
    return newsCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => NewsModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<NewsEntity>> readSingleNews(String newsId) {
    final newsCollection = firebaseFirestore.collection(FirebaseConst.content).doc(FirebaseConst.news).collection(FirebaseConst.news).orderBy("createAt", descending: true).where("newsId", isEqualTo: newsId);
    return newsCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => NewsModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> updateNews(NewsEntity news) async {
    final newsCollection = firebaseFirestore.collection(FirebaseConst.content).doc(FirebaseConst.news).collection(FirebaseConst.news);
    Map<String, dynamic> newsInfo = Map();

    if (news.description != "" && news.description != null) newsInfo['description'] = news.description;
    if (news.newsImageUrl != "" && news.newsImageUrl != null) newsInfo['newsImageUrl'] = news.newsImageUrl;

    newsCollection.doc(news.newsId).update(newsInfo);
  }
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;
  @override
  Future<String> uploadImageToStorage1(File? file, bool isNews, String childName) async {

    Reference ref = firebaseStorage.ref().child(childName).child(firebaseAuth.currentUser!.uid);

    if (isNews) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    final uploadTask = ref.putFile(file!);

    final imageUrl = (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }


}