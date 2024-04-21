import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/app/domain/entities/app_entity.dart';
import 'package:uni_link/features/post/comment/presentation/pages/comment/comment_page.dart';
import 'package:uni_link/features/post/domain/entities/post_entity.dart';
import 'package:uni_link/features/post/presentation/manager/post/get_single_post/get_single_post_cubit.dart';
import 'package:uni_link/features/post/presentation/manager/post/post_cubit.dart';
import 'package:uni_link/features/post/presentation/pages/post/update_post_page.dart';
import 'package:uni_link/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:uni_link/injection_container.dart' as di;
import 'package:intl/intl.dart';

class PostDetailMainWidget extends StatefulWidget {
  final String postId;
  const PostDetailMainWidget({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostDetailMainWidget> createState() => _PostDetailMainWidgetState();
}

class _PostDetailMainWidgetState extends State<PostDetailMainWidget> {

  String _currentUid = "";

  @override
  void initState() {

    BlocProvider.of<GetSinglePostCubit>(context).getSinglePost(postId: widget.postId);

    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }

  bool _isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Post Detail"),
      ),

      body: BlocBuilder<GetSinglePostCubit, GetSinglePostState>(
        builder: (context, getSinglePostState) {
          if (getSinglePostState is GetSinglePostLoaded) {
            final singlePost = getSinglePostState.post;
            return SingleChildScrollView(

              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,

                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: profileWidget(
                                          imageUrl: singlePost.userProfileUrl)

                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Text(
                                  "${singlePost.username}",
                                  style: TextStyle(
                                      color: oPrimaryColor, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          PopupMenuButton(itemBuilder: (context) {
                            return [
                              if(singlePost.creatorUid==_currentUid)PopupMenuItem(

                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => EditPostPage());

                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
                                    },
                                    child: Text(
                                      "Update Post",
                                      style: TextStyle(fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: oPrimaryColor),
                                    ),
                                  ),
                                ),
                              ),

                              if(singlePost.creatorUid==_currentUid) PopupMenuItem(


                                child: GestureDetector(
                                  onTap:_deletePost,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text("Delete Post",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),),
                                  ),
                                ),
                              )
                              ,

                            ];
                          },),
                          // GestureDetector(onTap: (){_openBottomModalSheet(context);
                          //   },child: const Icon(Icons.more_vert))
                        ]),
                    const SizedBox(height: 10,),
                    Text('${singlePost.description}'),
                    const SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.4,
                      child: profileWidget(imageUrl: "${singlePost.postImageUrl}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8.0),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: _likePost,
                                        child: Icon(
                                          singlePost.likes!.contains(_currentUid)
                                              ?
                                          Icons.thumb_up : Icons.thumb_up_alt_outlined,
                                          color: singlePost.likes!.contains(_currentUid)
                                              ? oPrimaryColor
                                              : Colors.blue,),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text('Like'),
                                    ],
                                  ),
                                  Text(
                                    "${singlePost.totalLikes} likes",

                                  ),
                                ],

                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() =>  CommentPage(appEntity: AppEntity(uid: _currentUid,postId: singlePost.postId),));
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.mode_comment_outlined,
                                          color: oPrimaryColor,),
                                        SizedBox(width: 8.0),
                                        Text('Comment'),
                                      ],
                                    ),
                                  ),

                                  GestureDetector(
                                      onTap: () {

                                      },
                                      child: Text(
                                        "${singlePost.totalComments} comments",
                                        style: TextStyle(color: Colors.grey),
                                      )),
                                ],
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.send_outlined, color: oPrimaryColor),
                                  SizedBox(width: 8.0),
                                  Text('Send'),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10,),
                          Text(
                            "${ DateFormat("dd/MMM/yyy").format(
                                singlePost.createAt!.toDate())}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );;

          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
  _openBottomModalSheet(BuildContext context, PostEntity post) {
    return showModalBottomSheet(context: context, builder: (context) {
      return Container(
        height: 150,
        decoration: BoxDecoration(),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: oPrimaryColor),
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
                    onTap: _deletePost,
                    child: Text(
                      "Delete Post",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),
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
                      Navigator.pushNamed(context, PageConst.updatePostPage, arguments: post);

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));

                    },
                    child: Text(
                      "Update Post",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),
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



  _deletePost() {
    BlocProvider.of<PostCubit>(context).deletePost(post: PostEntity(postId: widget.postId));
  }

  _likePost() {
    BlocProvider.of<PostCubit>(context).likePost(post: PostEntity(
        postId: widget.postId
    ));
  }
}

