import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/image_string.dart';
import 'package:uni_link/features/chat/domain/entities/chat_entities.dart';
import 'package:uni_link/features/chat/domain/entities/message_entities.dart';
import 'package:uni_link/features/chat/presentation/manager/cubit/chat/chat_cubit.dart';
import 'package:uni_link/features/chat/presentation/pages/chat/single_chat_page.dart';

import 'package:intl/intl.dart';
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';

class ChatPage extends StatefulWidget {
  final UserEntity currentUser;
  const ChatPage({super.key, required this.currentUser});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).getMyChat(chat: ChatEntity(senderUid: widget.currentUser.uid));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if(state is ChatLoaded) {
              final myChat = state.chatContacts;

              if(myChat.isEmpty) {
                return const Center(
                  child: Text("No Conversation Yet"),
                );
              }

              return ListView.builder(itemCount: myChat.length, itemBuilder: (context, index) {

                final chat = myChat[index];
                return GestureDetector(
                  onTap: () {
                   Get.to(()=>SingleChatPage(message:  MessageEntity(
                       senderUid: widget.currentUser.uid,
                       recipientUid:chat.recipientUid,
                       senderName: widget.currentUser.username,
                       recipientName: chat.recipientName,
                       senderProfile: chat.senderProfile,
                       recipientProfile: chat.recipientProfile,
                       uid: widget.currentUser.uid
                   )));

                  },
                  child: ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: profileWidget(),
                      ),
                    ),
                    title: Text("${chat.recipientName}"),
                    subtitle: Text("${chat.recentTextMessage}", maxLines: 1, overflow: TextOverflow.ellipsis,),
                    trailing: Text(
                      DateFormat.jm().format(chat.createdAt!.toDate()),
                      style: const TextStyle(color: greyColor, fontSize: 13),
                    ),
                  ),
                );
              });

            }
            return const Center(
              child: CircularProgressIndicator(
                color: tabColor,
              ),
            );
          },
        )
    );
  }
}
