import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/user/data/data_sources/user_remote_data_src.dart';
import 'package:uni_link/features/user/data/models/user_model.dart';
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';
import 'package:uni_link/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:uni_link/utils/exceptions/firebase_exceptions.dart';
import 'package:uni_link/utils/exceptions/platform_exceptions.dart';
import 'package:uuid/uuid.dart';

import '../../../../utils/popups/loaders.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSrc {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  UserRemoteDataSourceImpl(
      {required this.firebaseStorage,
      required this.firebaseFirestore,
      required this.firebaseAuth});

  //create User with image


  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
              uid: uid,
              email: user.email,
              bio: user.bio,
              isOnline: user.isOnline,
              connections: user.connections,
              website: user.website,
              profileUrl: user.profileUrl,
              username: user.username,
              privilege: user.privilege,
              university: user.university,
              department: user.department,
              totalConnection: user.totalConnection,
              totalPosts: user.totalPosts)
          .toJson();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
      } else {
        userCollection.doc(uid).update(newUser);
      }
    }).catchError((error) {
      toast("Some error occur");
    });
  }

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    final userCollection = firebaseFirestore
        .collection(FirebaseConst.users)
        .where("uid", isEqualTo: uid)
        .limit(1);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid!= null;

  @override
  Future signInUser(UserEntity user) async {
    try {
      if (user.email!.isNotEmpty || user.password!.isNotEmpty) {
        UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
            email: user.email!, password: user.password!);
        User? firebaseUser = result.user;
        return firebaseUser;
      } else {
        print("fields cannot be empty");
      }
    } on FirebaseAuthException catch (e) {
      throw OFirebaseAuthException(e.code).message;
      // Re-throwing the exception to handle it elsewhere if needed
    } on FormatException catch (e) {
      throw OFirebaseException(e.message);

    } on PlatformException catch (e) {
      throw  OPlatformException(e.code).message;

    } catch (e) {
      throw 'something went wrong please try again';
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> signUpUser(UserEntity user) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: user.email!, password: user.password!).then((currentUser) async{
        if (currentUser.user?.uid != null) {

          createUser(user);
        }});
      return;
    } on FirebaseAuthException catch (e) {
        Loader.errorSnackBar(title: 'oh Snap', message: e.toString());
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    Map<String, dynamic> userInformation = Map();

    if (user.username != "" && user.username != null)
      userInformation['username'] = user.username;

    if (user.website != "" && user.website != null)
      userInformation['website'] = user.website;
    if (user.privilege != "" && user.privilege != null)
      userInformation['website'] = user.privilege;

    if (user.profileUrl != "" && user.profileUrl != null)
      userInformation['profileUrl'] = user.profileUrl;

    if (user.bio != "" && user.bio != null) userInformation['bio'] = user.bio;
    if (user.university != "" && user.university != null)
      userInformation['bio'] = user.university;

    if (user.totalConnection != null)
      userInformation['totalConnection'] = user.totalConnection;

    if (user.totalPosts != null)
      userInformation['totalPosts'] = user.totalPosts;

    userCollection.doc(user.uid).update(userInformation);
  }

  @override
  Future<String> uploadImageToStorage(
      File? file, bool isPost, String childName) async {
    Reference ref = firebaseStorage
        .ref()
        .child(childName)
        .child(firebaseAuth.currentUser!.uid);

    if (isPost) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    final uploadTask = ref.putFile(file!);

    final imageUrl =
        (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }

  @override
  Stream<List<UserEntity>> getSingleOtherUser(String otherUid) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users).where("uid", isEqualTo: otherUid).limit(1);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }
}
