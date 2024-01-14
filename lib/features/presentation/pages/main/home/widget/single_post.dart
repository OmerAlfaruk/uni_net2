import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/image_string.dart';
import 'package:uni_link/features/domain/entities/post/post_entity.dart';
import 'package:uni_link/features/presentation/pages/main/home/comment/comment_page.dart';
import 'package:uni_link/features/presentation/pages/main/post/update_post_page.dart';
import 'package:intl/intl.dart';

import '../../../../../domain/use_cases/firebase_usecases/user/get_current_uid_usecase.dart';
import '../../../../cubit/post/post_cubit.dart';
import 'package:uni_link/injection_container.dart'as di;

class PostWidget extends StatefulWidget {
  final PostEntity post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  String _currentUid = "";

  @override
  void initState() {
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                            imageUrl: widget.post.userProfileUrl)

                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    "${widget.post.username}",
                    style: TextStyle(
                        color: oPrimaryColor, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            PopupMenuButton(itemBuilder: (context) {
              return [
              PopupMenuItem(

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

              PopupMenuItem(


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
            Text('${widget.post.description}'),
            const SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.4,
              child: profileWidget(imageUrl: "${widget.post.postImageUrl}"),
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
                                  widget.post.likes!.contains(_currentUid)
                                      ?
                                Icons.thumb_up : Icons.thumb_up_alt_outlined,
                                   color: widget.post.likes!.contains(_currentUid)
                                    ? oPrimaryColor
                                    : Colors.blue,),
                              ),
                              SizedBox(width: 8.0),
                              Text('Like'),
                            ],
                          ),
                          Text(
                            "${widget.post.totalLikes} likes",

                          ),
                        ],

                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const SingleCommentWidget());
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
                                "${widget.post.totalComments} comments",
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
                        widget.post.createAt!.toDate())}",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openBottomModalSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: oPrimaryColor),
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
                        child: Text(
                          "Delete Post",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: oPrimaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 7,),
                    Divider(
                      thickness: 1,
                      color: oSecondaryColor,
                    ),
                    SizedBox(height: 7,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => EditPostPage());

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
                        },
                        child: Text(
                          "Update Post",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: oPrimaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 7,),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _deletePost() {
    BlocProvider.of<PostCubit>(context)
        .deletePost(post: PostEntity(postId: widget.post.postId));
  }

  _likePost() {
    BlocProvider.of<PostCubit>(context)
        .likePost(post: PostEntity(postId: widget.post.postId));
  }
}