import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/admin/user%20management/presentation/user_mangement.dart';
import 'package:uni_link/features/main/home.dart';
import 'package:uni_link/features/main/upload.dart';
import 'package:uni_link/features/nework/presentation/pages/network/network.dart';

import 'package:uni_link/features/post/presentation/pages/home/post.dart';
import 'package:uni_link/features/post/presentation/pages/post/upload_post.dart';
import 'package:uni_link/features/profile/presentation/pages/profile/profile.dart';
import 'package:uni_link/features/search/presentation/pages/search/search.dart';
import 'package:uni_link/features/admin/user%20management/presentation/add_single_user.dart';
import 'package:uni_link/features/user/presentation/manager/user/user_cubit/user/get_single_user/get_single_user_cubit.dart';


class MainScreen extends StatefulWidget {
  final String uid;

  const MainScreen({Key? key, required this.uid}) : super(key: key);



  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context,getSingleUserState ) {
      if (getSingleUserState is GetSingleUserLoaded) {
        final currentUser = getSingleUserState.user;
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: oPrimaryColor,
              unselectedItemColor: Colors.blue.shade300,
              currentIndex: _currentIndex,
              items:  [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                      size: 35,
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add,
                      size: 35,
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.supervised_user_circle_outlined,
                      size: 35,
                    ),
                    label: ""),
                if(currentUser.privilege=='Admin') BottomNavigationBarItem(
          icon: Icon(
            Icons.add_circle_outline,
            size: 35,
          ),
                label: "")
              ],
              onTap: navigationTapped,
            ),
            body: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: [
                HomePage(),
                currentUser.privilege=='Communicator'?UploadPage():currentUser.privilege=='Faculty Representative'?UploadPage():UploadPostPage(currentUser: currentUser,),
                NetworkPage(user: currentUser,),
                if(currentUser.privilege=='Admin')UserManagement()
              ],
            ),
          ),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
      },
    );
  }
}
