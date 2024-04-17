import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/chat/presentation/pages/chat/chat_page.dart';
import 'package:uni_link/features/post/presentation/pages/home/widget/tab_bar.dart';
import 'package:uni_link/features/user/user_cubit/user/get_single_user/get_single_user_cubit.dart';

import 'contact_page.dart';

class AllContact extends StatefulWidget {
  const AllContact({super.key});

  @override
  State<AllContact> createState() => _AllContactState();
}

class _AllContactState extends State<AllContact> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserState) {
        if (getSingleUserState is GetSingleUserLoaded) {
          final currentUser = getSingleUserState.user;
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,

              ),

              body: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                        child: Text('Contact'),
                      ),
                      Tab(
                        child: Text('chat'),

                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ContactPage(uid: currentUser.uid),
                        ChatPage(currentUser: currentUser),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );

  }
}
