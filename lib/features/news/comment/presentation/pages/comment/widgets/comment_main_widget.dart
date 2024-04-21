import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/app/domain/entities/app_entity.dart';
import 'package:uni_link/features/news/comment/domain/entities/comment_entity.dart';
import 'package:uni_link/features/news/comment/presentation/managers/comment_cubit.dart';
import 'package:uni_link/features/news/comment/presentation/pages/comment/widgets/single_comment_widget.dart';
import 'package:uni_link/features/news/comment/replay/presentation/manager/replay/replay_cubit.dart';
import 'package:uni_link/features/news/presentaion/managers/news/get_single_new/get_single_news_cubit.dart';
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';
import 'package:uni_link/features/user/presentation/manager/user/user_cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:uuid/uuid.dart';
import 'package:uni_link/injection_container.dart'as di;




class CommentMainWidget extends StatefulWidget {
  final AppEntity appEntity;

  const CommentMainWidget({Key? key, required this.appEntity}) : super(key: key);

  @override
  State<CommentMainWidget> createState() => _CommentMainWidgetState();
}

class _CommentMainWidgetState extends State<CommentMainWidget> {
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.appEntity.uid!);

    BlocProvider.of<GetSingleNewsCubit>(context).getSingleNews(newsId: widget.appEntity.newsId!);

    BlocProvider.of<NewsCommentCubit>(context).getComments(newsId: widget.appEntity.newsId!);

    super.initState();
  }

  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text("Comments"),
      ),
      body: BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, singleUserState) {
          if (singleUserState is GetSingleUserLoaded) {
            final singleUser = singleUserState.user;
            return BlocBuilder<GetSingleNewsCubit, GetSingleNewsState>(
              builder: (context, singleNewsState) {
                if (singleNewsState is GetSingleNewsLoaded) {
                  final singleNews = singleNewsState.news;
                  return BlocBuilder<NewsCommentCubit, NewsCommentState>(
                    builder: (context, commentState) {

                      if (commentState is CommentLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: profileWidget(imageUrl: singleNews.userProfileUrl),
                                        ),
                                      ),
                                      sizeHor(10),
                                      Text(
                                        "${singleNews.username}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color:oPrimaryColor),
                                      ),
                                    ],
                                  ),
                                  sizeVer(10),
                                  Text(
                                    "${singleNews.description}",
                                    style: TextStyle(color: oPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                            sizeVer(10),
                            Divider(
                              color: oSecondaryColor,
                            ),
                            sizeVer(10),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: commentState.comments.length,
                                  itemBuilder: (context, index) {
                                    final singleComment = commentState.comments[index];
                                    return BlocProvider(
                                      create: (context) => di.sl<NewsReplayCubit>(),
                                      child: SingleCommentWidget(
                                        currentUser: singleUser,
                                        comment: singleComment,
                                        onLongPressListener: () {
                                         if(singleUser.uid==singleComment.creatorUid){ _openBottomModalSheet(
                                            context: context,
                                            comment: commentState.comments[index],
                                          );}
                                        },
                                        onLikeClickListener: () {
                                          _likeComment(comment: commentState.comments[index]);
                                        },
                                      ),
                                    );
                                  }),
                            ),
                            _commentSection(currentUser: singleUser)
                          ],
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _commentSection({required UserEntity currentUser}) {
    return Container(
      width: double.infinity,
      height: 55,
      color: Colors.grey[800],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: profileWidget(imageUrl: currentUser.profileUrl),
              ),
            ),
            sizeHor(10),
            Expanded(
                child: TextFormField(
                  controller: _descriptionController,
                  style: TextStyle(color: oPrimaryColor),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Post your comment...",
                      hintStyle: TextStyle(color: oSecondaryColor)),
                )),
            GestureDetector(
                onTap: () {
                  _createComment(currentUser);
                },
                child: Text(
                  "Post",
                  style: TextStyle(fontSize: 15, color: oPrimaryColor),
                ))
          ],
        ),
      ),
    );
  }

  _createComment(UserEntity currentUser) {
    BlocProvider.of<NewsCommentCubit>(context)
        .createComment(
        comment: CommentEntity(
          totalReplays: 0,
          commentId: Uuid().v1(),
          createAt: Timestamp.now(),
          likes: [],
          username: currentUser.username,
          userProfileUrl: currentUser.profileUrl,
          description: _descriptionController.text,
          creatorUid: currentUser.uid,
          newsId: widget.appEntity.newsId,
        ))
        .then((value) {
      setState(() {
        _descriptionController.clear();
      });
    });
  }

  _openBottomModalSheet({required BuildContext context, required CommentEntity comment}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "More Options",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18, color: oPrimaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      thickness: 1,
                      color: oSecondaryColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          _deleteComment(commentId: comment.commentId!, newsId: comment.newsId!);
                        },
                        child: Text(
                          "Delete Comment",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),
                        ),
                      ),
                    ),
                    sizeVer(7),
                    Divider(
                      thickness: 1,
                      color: oSecondaryColor,
                    ),
                    sizeVer(7),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, PageConst.updateCommentPage,
                              arguments: comment);

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
                        },
                        child:Text(
                          "Update Comment",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),
                        ),
                      ),
                    ),
                    sizeVer(7),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _deleteComment({required String commentId, required String newsId}) {
    BlocProvider.of<NewsCommentCubit>(context)
        .deleteComment(comment: CommentEntity(commentId: commentId, newsId: newsId));
  }

  _likeComment({required CommentEntity comment}) {
    BlocProvider.of<NewsCommentCubit>(context)
        .likeComment(comment: CommentEntity(commentId: comment.commentId, newsId: comment.newsId));
  }
}
