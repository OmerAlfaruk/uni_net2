import 'dart:ffi';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/data/data_sources/firebase_remote_data_src.dart';
import 'package:uni_link/features/data/models/user/user_model.dart';
import 'package:uni_link/features/domain/entities/user/user_entity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource{

  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;


  FirebaseRemoteDataSourceImpl({ required this.firebaseFirestore, required this.firebaseAuth});

  //create User with image
  Future<void> createUserWithImage(UserEntity user, String profileUrl) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
          uid: uid,
          name: user.name,
          email: user.email,
          bio: user.bio,
          connections: user.connections,
          website: user.website,
          profileUrl: profileUrl,
          username: user.username,
          university: user.university,
          totalConnection: user.totalConnection,
          totalPosts: user.totalPosts
      ).toJson();

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
  Future<void> createUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);

    final uid = await getCurrentUid();

    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
          uid: uid,
          name: user.name,
          email: user.email,
          bio: user.bio,
          connections: user.connections,
          website: user.website,
          profileUrl: user.profileUrl,
          username: user.username,
          university: user.university,
          totalConnection: user.totalConnection,
          totalPosts: user.totalPosts
      ).toJson();

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
    final userCollection = firebaseFirestore.collection(FirebaseConst.users).where("uid", isEqualTo: uid).limit(1);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    return userCollection.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> signInUser(UserEntity user)async {
    try {
      if (user.email!.isNotEmpty || user.password!.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(email: user.email!, password: user.password!);
      } else {
        print("fields cannot be empty");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        toast("user not found");
      } else if (e.code == "wrong-password") {
        toast("Invalid email or password");
      }
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
      if (e.code == "email-already-in-use") {
        toast("email is already taken");
      } else {
        toast("something went wrong");
      }
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    Map<String, dynamic> userInformation = Map();

    if (user.username != "" && user.username != null) userInformation['username'] = user.username;

    if (user.website != "" && user.website != null) userInformation['website'] = user.website;

    if (user.profileUrl != "" && user.profileUrl != null) userInformation['profileUrl'] = user.profileUrl;

    if (user.bio != "" && user.bio != null) userInformation['bio'] = user.bio;
    if (user.university != "" && user.university != null) userInformation['bio'] = user.university;

    if (user.name != "" && user.name != null) userInformation['name'] = user.name;

    if (user.totalConnection != null) userInformation['totalConnection'] = user.totalConnection;

    if (user.totalPosts != null) userInformation['totalPosts'] = user.totalPosts;

    userCollection.doc(user.uid).update(userInformation);

  }
  @override
  Future<String> uploadImageToStorage(File? file, bool isPost, String childName) async {

   Reference ref = FirebaseStorage.instance.ref().child(childName).child(firebaseAuth.currentUser!.uid);

    if (isPost) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    final uploadTask = ref.putFile(file!);

    final imageUrl = (await uploadTask.whenComplete(() {})).ref.getDownloadURL();

    return await imageUrl;
  }

}