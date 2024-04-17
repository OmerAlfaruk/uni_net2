import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/post/domain/entities/post_entity.dart';
import 'package:uni_link/features/post/presentation/manager/post/post_cubit.dart';
import 'package:uni_link/features/post/presentation/pages/home/widget/single_post.dart';
import 'package:uni_link/features/presentation/widgets/appbar_widget.dart';
import 'package:uni_link/injection_container.dart' as di;

class AnnouncementsPage extends StatelessWidget {
  const  AnnouncementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<PostCubit>(
          create: (context) => di.sl<PostCubit>()..getPosts(post: PostEntity()),
          child: BlocBuilder<PostCubit, PostState>(
            builder: (context, postState) {
              if (postState is PostLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (postState is PostFailure) {
                toast("Some Failure occured while creating the post");
              }
              if (postState is PostLoaded) {
                return postState.post.isEmpty
                    ? _noPostsYetWidget()
                    : ListView.builder(
                  itemCount: postState.post.length,
                  itemBuilder: (context, index) {
                    final post = postState.post[index];
                    if(post.postType=='Announcements'){
                      return BlocProvider(
                        create: (context) => di.sl<PostCubit>(),
                        child: PostWidget(post: post),

                      );}
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  _noPostsYetWidget() {
    return Center(
      child: Text(
        "No Announcements Yet",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
