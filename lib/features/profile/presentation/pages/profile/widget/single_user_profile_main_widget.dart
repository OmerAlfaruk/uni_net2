import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/chat/domain/entities/message_entities.dart';
import 'package:uni_link/features/chat/presentation/pages/chat/single_chat_page.dart';
import 'package:uni_link/features/nework/presentation/pages/network/network.dart';
import 'package:uni_link/features/post/domain/entities/post_entity.dart';
import 'package:uni_link/features/post/presentation/manager/post/post_cubit.dart';
import 'package:uni_link/features/post/presentation/pages/post/post_detail_page.dart';
import 'package:uni_link/features/presentation/widgets/button_container_widget.dart';
import 'package:uni_link/features/profile/presentation/manager/get_single_other_user_cubit.dart';
import 'package:uni_link/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';
import 'package:uni_link/features/user/presentation/manager/user/user_cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:uni_link/features/user/presentation/manager/user/user_cubit/user/user_cubit.dart';
import 'package:uni_link/injection_container.dart' as di;

class SingleUserProfileMainWidget extends StatefulWidget {
  final String otherUserId;

  const SingleUserProfileMainWidget({Key? key, required this.otherUserId,})
      : super(key: key);

  @override
  State<SingleUserProfileMainWidget> createState() => _SingleUserProfileMainWidgetState();
}

class _SingleUserProfileMainWidgetState extends State<SingleUserProfileMainWidget> {
  String _currentUid = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, state) {
          if(state is GetSingleUserLoaded) {
            final currentUser = state.user;
    return BlocBuilder<GetSingleOtherUserCubit, GetSingleOtherUserState>(
      builder: (context, userState) {
        if (userState is GetSingleOtherUserLoaded) {
          final singleUser = userState.otherUser;
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  "${singleUser.username}",
                  style: TextStyle(color: oPrimaryColor),
                ),

              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(75),
                            child: profileWidget(
                                imageUrl: singleUser.profileUrl),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "From ${singleUser.university}",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(color: oPrimaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Profession : ",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: oPrimaryColor)
                      ),  const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Department : ${singleUser.department}",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: oPrimaryColor)
                      ),  const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Bio : ${singleUser.bio}",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: oPrimaryColor)
                      ),  const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "WebSites : ${singleUser.website}",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: oPrimaryColor)
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${singleUser.totalPosts}",
                            style: TextStyle(
                              color: oPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Posts",
                            style: TextStyle(color: oPrimaryColor),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => NetworkPage(user: singleUser));
                        },
                        child: Column(
                          children: [
                            Text(
                              "${singleUser.totalConnection}",
                              style: TextStyle(
                                color: oPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Connections",
                              style: TextStyle(color: oPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap:  ()=>Get.to(()=>SingleChatPage(message:   MessageEntity(
                            senderUid: currentUser.uid,
                            recipientUid: singleUser.uid,
                            senderName: currentUser.username,
                            recipientName: singleUser.username,
                            senderProfile: currentUser.profileUrl,
                            recipientProfile: singleUser.profileUrl,
                            uid:widget.otherUserId
                        ))),
                        child: Column(
                          children: [
                            Icon(Iconsax.message,color: oPrimaryColor,),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Send Message",
                              style: TextStyle(color: oPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                        height: 20,
                      ),
                       _currentUid == singleUser.uid ? Container():singleUser.connections!.contains(_currentUid)?ButtonContainerWidget(
                                               text: "Un Connect",
                                               onTapListener: () {
                       BlocProvider.of<UserCubit>(context).followUnFollowUser(
                           user: UserEntity(
                               uid: _currentUid,
                               otherUid: widget.otherUserId
                           ),
                       );

                                               },
                       ):ButtonContainerWidget(
                                    text: "Connect",
                                    onTapListener: () {
                                      BlocProvider.of<UserCubit>(context).followUnFollowUser(
                                          user: UserEntity(
                       uid: _currentUid,
                       otherUid: widget.otherUserId
                                          )
                                      );

                                    },
                                  ),
                      SizedBox(
                        height: 20,
                      ),


                      BlocBuilder<PostCubit, PostState>(
                        builder: (context, postState) {
                          if (postState is PostLoaded) {
                            final posts = postState.post.where((post) => post.creatorUid == widget.otherUserId).toList();;
                            return GridView.builder(
                                itemCount: posts.length,
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(()=>PostDetailPage(postId: '${posts[index].postId}'));
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      child: profileWidget(imageUrl: posts[index].postImageUrl),
                                    ),
                                  );
                                });
                          }
                          return Center(child: CircularProgressIndicator(),);
                        },
                      ),
                    ],
                  ),
                ),

              ));
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
          return Center(child: CircularProgressIndicator(),);},
);
  }

  void initState() {
    BlocProvider.of<GetSingleOtherUserCubit>(context).getSingleOtherUser(otherUid: widget.otherUserId);
    BlocProvider.of<PostCubit>(context).getPosts(post: PostEntity());
    super.initState();

    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
  }
}