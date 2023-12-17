
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/features/presentation/pages/main/chat/chat_page.dart';
import 'package:uni_link/features/presentation/pages/main/notifications/notifications.dart';
import 'package:uni_link/utils/theme/theme.dart';

PreferredSizeWidget appBarWidget(BuildContext context, {VoidCallback? onLeadingTapClickListener, String? title, bool? isChatPage}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: GestureDetector(
      onTap: onLeadingTapClickListener,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(borderRadius: BorderRadius.circular(50),child: Image.asset("assets/images/general/profile_1.jpeg",)),
      ),
    ),
    title: isChatPage == false?Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "$title",
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search)),
      ),
    ): Column(
      children: [
        Text('Username', style:Theme.of(context).textTheme.bodySmall),
        Text('Online', style:Theme.of(context).textTheme.bodySmall),
      ],
    ),
    actions: [
      isChatPage == false?GestureDetector(
        onTap: () {
          Get.to(()=>const NotificationsPage());
        },
        child: const Icon(
          Icons.notifications_none,
          size: 35,
          color: Colors.black,
        ),


      ) :Container(),
      SizedBox(width: 6,),

      isChatPage == false?GestureDetector(
        onTap: () {
          Get.to(()=>const ChatPage());
        },
        child: const Icon(
          Icons.message_outlined,
          size: 35,
          color: Colors.black,
        ),


      ) : const Row(
        children: [
          Icon(Icons.more_vert, size: 35,color: Colors.black,),

        ],
      ),

    ],
  );
}