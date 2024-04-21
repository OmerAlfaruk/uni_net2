import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/chat/presentation/pages/chat/chat_page.dart';
import 'package:uni_link/features/post/domain/entities/post_entity.dart';
import 'package:uni_link/features/event/presentation/pages/event_screen/event_page.dart';
import 'package:uni_link/features/notificatio/presentation/pages/notifications/notifications.dart';


import '../../../common_widget/profile_widget/profile_widget.dart';

PreferredSizeWidget appBarWidget(
  BuildContext context, {String ? imageUrl,
  VoidCallback? onLeadingTapClickListener,
      VoidCallback? onTap,
  String? title,
  bool? isChatPage,
}) {

  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: GestureDetector(
      onTap: onLeadingTapClickListener,
   child: ClipRRect(
       borderRadius: BorderRadius.circular(15),
       child: profileWidget(

   ),

    ),),
    title: isChatPage == false
        ? Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "$title",
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search)),
            ),
          )
        : Column(
            children: [
              Text('Username', style: Theme.of(context).textTheme.bodySmall),
              Text('Online', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
    actions: [
      isChatPage == false
          ? Row(
              children: [
                AppBarActionWidget(
                  icon: Icons.notifications_none,
                  onPressed: () {
                    Get.to(() => const NotificationsPage());
                  }, ammount: '9',
                ),
                AppBarActionWidget(

                  icon: Icons.calendar_month_outlined,
                  onPressed: () {
                    Get.to(() => EventPage());
                  }, ammount: '5',
                ),
                AppBarActionWidget(
                  icon: Icons.message_outlined,
                  onPressed:onTap, ammount: '13',
                ),
              ])
          : const Row(
              children: [
                Icon(
                  Icons.more_vert,
                  size: 35,
                  color: Colors.black,
                ),
              ],
            ),
      const SizedBox(
        width: 10,
      )
    ],
  );
}

class AppBarActionWidget extends StatelessWidget {
  const AppBarActionWidget({
    super.key,
    this.icon,
    this.onPressed, this.ammount,
  });

  final IconData? icon;
  final VoidCallback? onPressed;
  final String? ammount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          color: oPrimaryColor,
          onPressed: onPressed,
          icon: Icon(icon),
        ),
        Positioned(
            right: 10,
            bottom: 1,
            height: 20,
            width: 20,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                ammount!,
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
            ))
      ],
    );
  }
}
