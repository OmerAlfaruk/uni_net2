

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/image_string.dart';
import 'package:uni_link/features/presentation/pages/main/chat/single_chat_page.dart';

import 'package:intl/intl.dart';
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemCount: 20,itemBuilder: (context, index) {
         return GestureDetector(
           onTap: () {
             Get.to(()=>const SingleChatPage());
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
             title: const Text("Username"),
             subtitle: const Text("last message hi", maxLines: 1, overflow: TextOverflow.ellipsis,),
             trailing: Text(
               DateFormat.jm().format(DateTime.now()),

               style: const TextStyle(color: Colors.grey, fontSize: 13),
             ),
           ),
         );
      })
    );
  }
}
