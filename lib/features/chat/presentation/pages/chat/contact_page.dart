import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/text_string.dart';
import 'package:uni_link/features/chat/domain/entities/message_entities.dart';
import 'package:uni_link/features/chat/presentation/pages/chat/single_chat_page.dart';

import 'package:uni_link/features/profile/presentation/pages/single_user_profile_page.dart';
import 'package:uni_link/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:uni_link/features/user/user_cubit/user/get_single_user/get_single_user_cubit.dart';

import 'package:uni_link/features/user/user_cubit/user/user_cubit.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';
import 'package:uni_link/injection_container.dart'as di;
class ContactPage extends StatefulWidget {
  final String? uid;

  const ContactPage({super.key, required this.uid});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
        builder: (context, state) {
          if(state is GetSingleUserLoaded) {
            final currentUser = state.user;
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {

          final filterAllUsers =
          userState.users.toList();
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: filterAllUsers.length,
                  physics: ScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          onTap:  ()=>Get.to(()=>SingleChatPage(message:   MessageEntity(
                              senderUid: currentUser.uid,
                              recipientUid: filterAllUsers[index].uid,
                              senderName: currentUser.username,
                              recipientName: filterAllUsers[index].username,
                              senderProfile: currentUser.profileUrl,
                              recipientProfile: filterAllUsers[index].profileUrl,
                              uid: widget.uid
                          ),)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: profileWidget(imageUrl: filterAllUsers[index].profileUrl),
                          ),
                        ),
                      ),
                      title: Text(
                        "${filterAllUsers[index].username}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                        "${filterAllUsers[index].totalConnection} connection",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      trailing: Text("Online"),
                    );
                  },
                )
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
       return   Center(child: CircularProgressIndicator());  },
);
  }

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers(user: UserEntity());
    super.initState();
  }
}
