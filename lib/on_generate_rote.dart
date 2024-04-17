import 'package:flutter/material.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';


import 'constant/const.dart';
import 'features/app/domain/entities/app_entity.dart';
import 'features/post/comment/domain/entities/comment_entity.dart';
import 'features/post/comment/presentation/pages/comment/comment_page.dart';
import 'features/post/comment/presentation/pages/comment/edit_comment_page.dart';
import 'features/post/comment/replay/presentation/pages/edit_replay_page.dart';
import 'features/post/comment/replay/domain/entities/replay_entity.dart';
import 'features/profile/presentation/pages/profile/edit_profile_page.dart';
import 'features/user/credential/presentation/pages/credential/sign_in_page.dart';
import 'features/admin/user management/presentation/add_single_user.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case PageConst.editProfilePage: {
        if (args is UserEntity) {
          return routeBuilder(EditProfilePage(currentUser: args,));

        } else {
          return routeBuilder(NoPageFound());
        }

      }
      // case PageConst.updatePostPage: {
      //   if (args is PostEntity) {
      //     return routeBuilder(EditPostPage(post: args,));
      //
      //   }
      //else {
       //   return routeBuilder(NoPageFound());
      //  }
      //}
      case PageConst.updateCommentPage: {
        if (args is CommentEntity) {
          return routeBuilder(EditCommentPage(comment: args,));

        } else {
          return routeBuilder(NoPageFound());
        }
      }
      case PageConst.updateReplayPage: {
        if (args is ReplayEntity) {
          return routeBuilder(EditReplayPage(replay: args,));

        } else {
          return routeBuilder(NoPageFound());
        }
      }
      case PageConst.commentPage: {
        if (args is AppEntity) {
          return routeBuilder(CommentPage(appEntity: args,));
        }
        return routeBuilder(NoPageFound());
      }

      // case PageConst.postDetailPage: {
      //   if (args is String) {
      //     return routeBuilder(PostDetailPage(postId: args,));
      //   }
      //   return routeBuilder(NoPageFound());
      // }
      //case PageConst.singleUserProfilePage: {
      //   if (args is String) {
      //     return routeBuilder(SingleUserProfilePage(otherUserId: args,));
      //   }
      //   return routeBuilder(NoPageFound());
      // }
      // case PageConst.followingPage: {
      //   if (args is UserEntity) {
      //     return routeBuilder(FollowingPage(user: args,));
      //   }
      //   return routeBuilder(NoPageFound());
      // }
      // case PageConst.followersPage: {
      //   if (args is UserEntity) {
      //     return routeBuilder(FollowersPage(user: args,));
      //   }
      //   return routeBuilder(NoPageFound());
      // }

      case PageConst.signInPage: {
        return routeBuilder(SignInPage());
      }
      case PageConst.signUpPage: {
        return routeBuilder(AddSingleUserPage());
      }
      case PageConst.signUpPage: {
        return routeBuilder(AddSingleUserPage());
      }
      default: {
        NoPageFound();
      }
    }
    return null;
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page not found"),
      ),
      body: Center(child: Text("Page not found"),),
    );
  }
}



