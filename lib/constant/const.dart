import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giphy_picker/giphy_picker.dart';

class PageConst {
  static const String editProfilePage = "editProfilePage";
  static const String updatePostPage = "updatePostPage";

  static const String commentPage = "commentPage";
  static const String signInPage = "signInPage";
  static const String signUpPage = "signUpPage";
  static const String updateCommentPage = "updateCommentPage";
  static const String updateReplayPage = "updateReplayPage";
  static const String postDetailPage = "postDetailPage";
  static const String singleUserProfilePage = "singleUserProfilePage";
  static const String network= "NetworkPage";
}

class FirebaseConst {
  static const String users = "users";
  static const String content = "content";
  static const String news = "news";
  static const String posts = "posts";
  static const String comment = "comment";
  static const String replay = "replay";
  static const String announcements = "announcements";
  static const String oneToOneChatChannel = "oneToOneChatChannel";
  static const String chatChannel = "chatChannel";
  static const String myChat = "myChat";
  static const String messages = "messages";


}
Widget sizeVer(double height) {
  return SizedBox(height: height,);
}

Widget sizeHor(double width) {
  return SizedBox(width: width);
}


void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0);
}
Future<GiphyGif?> pickGIF(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await GiphyPicker.pickGif(
        context: context,
        apiKey: 'kLu4PIKAwS2ys47Ji7oWUIr2iZbEoj1k');

  } catch (e) {
    toast(e.toString());
  }

  return gif;
}
