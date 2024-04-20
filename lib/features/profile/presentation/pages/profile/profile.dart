import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/post/presentation/manager/post/post_cubit.dart';

import 'package:uni_link/features/presentation/pages/app/settings/settings.dart';
import 'package:uni_link/features/profile/presentation/pages/profile/widget/profile_widget.dart';
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';
import 'package:uni_link/features/user/presentation/manager/auth/auth_cubit.dart';

import 'package:uni_link/injection_container.dart' as di;


import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  final UserEntity currentUser;

  const ProfilePage({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
  create:  (context) => di.sl<PostCubit>(),
  child:Expanded(child: ProfileMainWidget(currentUser: currentUser,)),
);
  }


  _openBottomModalSheet({required BuildContext context,}) {
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
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "More Options",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: oPrimaryColor),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    onTap: () {
                     Get.to(()=>EditProfilePage(currentUser:currentUser,));
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                    },
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),
                    ),
                  ),
                ),
              const SizedBox(height: 7,),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 7,),
                GestureDetector(
                  onTap: (){BlocProvider.of<AuthCubit>(context).loggedOut();},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Logout",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),
                    ),
                  ),
                ),
                const SizedBox(height: 7,),
              ],
            ),
          ),
        ),
      );
    });
  }
}