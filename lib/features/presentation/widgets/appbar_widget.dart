import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/domain/entities/user/user_entity.dart';
import 'package:uni_link/features/presentation/pages/main/chat/chat_page.dart';
import 'package:uni_link/features/presentation/pages/main/event_screen/event_detail_page.dart';
import 'package:uni_link/features/presentation/pages/main/event_screen/event_page.dart';
import 'package:uni_link/features/presentation/pages/main/notifications/notifications.dart';
import 'package:uni_link/features/presentation/pages/main/profile/profile.dart';

PreferredSizeWidget appBarWidget(
  BuildContext context, {
  VoidCallback? onLeadingTapClickListener,
  String? title,
  bool? isChatPage,
}) {
  final UserEntity currentUser;
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: GestureDetector(
      onTap: onLeadingTapClickListener,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
            onTap: () {}, //()=>Get.to(()=>ProfilePage(,)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  "assets/images/general/profile_1.jpeg",
                ))),
      ),
    ),
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
                  onPressed: () {
                    Get.to(() => const ChatPage());
                  }, ammount: '13',
                ),
              ],
            )
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
