import 'package:flutter/material.dart';
import 'package:uni_link/features/presentation/pages/main/post/update_post_page.dart';

import 'constant/const.dart';
import 'features/domain/entities/user/user_entity.dart';
import 'features/presentation/pages/credential/sign_in_page.dart';
import 'features/presentation/pages/credential/sign_up_page.dart';
import 'features/presentation/pages/main/profile/edit_profile_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case PageConst.editProfilePage: {
        if (args is UserEntity) {
          return routeBuilder(EditProfilePage());

        } else {
          return routeBuilder(NoPageFound());
        }

      }
      case PageConst.updatePostPage: {

          return routeBuilder(EditPostPage());


      }
      case PageConst.updateCommentPage: {




      }
      case PageConst.updateReplayPage: {

      }
      case PageConst.commentPage: {


        return routeBuilder(NoPageFound());
      }
      case PageConst.postDetailPage: {

      }
      case PageConst.singleUserProfilePage: {

      }




      case PageConst.signInPage: {
        return routeBuilder(SignInPage());
      }
      case PageConst.signUpPage: {
        return routeBuilder(SignUpPage());
      }
      case PageConst.signUpPage: {
        return routeBuilder(SignUpPage());
      }
      default: {
        NoPageFound();
      }
    }
    return null;
  }
}

class PostEntity {
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

