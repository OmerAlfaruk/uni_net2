import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/image_string.dart';
import 'package:uni_link/features/nework/presentation/pages/network/network.dart';
import 'package:uni_link/features/post/domain/entities/post_entity.dart';
import 'package:uni_link/features/post/presentation/manager/post/post_cubit.dart';
import 'package:uni_link/features/post/presentation/pages/post/post_detail_page.dart';
import 'package:uni_link/features/presentation/pages/app/settings/settings.dart';
import 'package:uni_link/features/presentation/widgets/button_container_widget.dart';
import 'package:uni_link/features/profile/presentation/pages/profile/edit_profile_page.dart';
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';
import 'package:uni_link/features/user/presentation/manager/auth/auth_cubit.dart';
import 'package:uni_link/features/user/presentation/pages/login/sign_in_page.dart';

import '../../../../../../constant/color.dart';

class ProfileMainWidget extends StatefulWidget {
  const ProfileMainWidget({super.key, required this.currentUser});

  final UserEntity currentUser;

  @override
  State<ProfileMainWidget> createState() => _ProfileMainWidgetState();
}

class _ProfileMainWidgetState extends State<ProfileMainWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "${widget.currentUser.username}",
          style: TextStyle(color: oPrimaryColor),
        ),
        actions: [
          PopupMenuButton(
              iconColor: oPrimaryColor,

              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context){
                return [
                  PopupMenuItem(

                    child:Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(()=>EditProfilePage(currentUser:widget.currentUser,));
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                        },
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),
                        ),
                      ),
                    ),
                  ),

                  PopupMenuItem(

                    child: GestureDetector(
                      onTap:()=>Get.to(()=>SettingsScreen()),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("Settings",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),),
                      ),
                    ),
                  ),

                  PopupMenuItem(

                    child: GestureDetector(
                      onTap: (){BlocProvider.of<AuthCubit>(context).loggedOut();
                      Get.offAll(SignInPage());},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Logout",
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                ];
              }
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: profileWidget(imageUrl: widget.currentUser.profileUrl),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "From ${widget.currentUser.university}",
          style:Theme.of(context).textTheme.headlineSmall!.apply(color: oPrimaryColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${widget.currentUser.bio}",
                  style:Theme.of(context).textTheme.headlineSmall!.apply(color: oPrimaryColor)
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
                          "${widget.currentUser.totalPosts}",
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
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => NetworkPage(user: widget.currentUser));
                      },
                      child: Column(
                        children: [
                          Text(
                            "${widget.currentUser.totalConnection}",
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
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),


              SizedBox(
                height: 30,
              ),



              BlocBuilder<PostCubit, PostState>(
                builder: (context, postState) {
                  if (postState is PostLoaded) {
                    final posts = postState.post.where((post) => post.creatorUid == widget.currentUser.uid).toList();;
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
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<PostCubit>(context).getPosts(post: PostEntity());
    super.initState();
  }
}
