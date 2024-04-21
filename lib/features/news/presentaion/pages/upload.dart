import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/news/presentaion/pages/upload_news.dart';
import 'package:uni_link/features/post/presentation/pages/post/upload_post.dart';
import 'package:uni_link/features/user/presentation/manager/user/user_cubit/user/get_single_user/get_single_user_cubit.dart';



class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context,getSingleUserState ) {
        if (getSingleUserState is GetSingleUserLoaded) {
          final currentUser = getSingleUserState.user;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(title: Text('Add User',style: TextStyle(color: oPrimaryColor),),),
              body: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        Get.to(()=>UploadNewsPage(currentUser: currentUser));
                      },
                      child: Container(

                        child: Text('Upload News'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Get.to(()=>UploadPostPage(currentUser: currentUser));
                      },
                      child: Container(

                        child: Text('Upload Post'),
                      ),
                    ),
                  ],
                ),
              ),

            )
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

  }
}