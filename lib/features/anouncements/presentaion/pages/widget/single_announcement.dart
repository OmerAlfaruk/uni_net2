import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/image_string.dart';
import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';
import 'package:uni_link/features/anouncements/presentaion/managers/announcements_cubit.dart';
import 'package:uni_link/features/anouncements/presentaion/pages/update_announcements_page.dart';
import 'package:uni_link/features/app/domain/entities/app_entity.dart';
import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:intl/intl.dart';
import 'package:uni_link/features/news/presentaion/pages/update_news_page.dart';
import 'package:uni_link/features/profile/presentation/pages/profile/profile.dart';
import 'package:uni_link/features/profile/presentation/pages/single_user_profile_page.dart';
import 'package:uni_link/features/user/domain/use_cases/get_current_uid_usecase.dart';



import 'package:uni_link/injection_container.dart'as di;

class AnnouncementWidget extends StatefulWidget {
  final AnnouncementsEntity announcements;

  const AnnouncementWidget({super.key, required this.announcements});

  @override
  State<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  String _currentUid = "";



  @override
  void initState() {
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(SingleUserProfilePage(otherUserId:'${widget.announcements.creatorUid}'),);

              },
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,

                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: profileWidget(
                            imageUrl: widget.announcements.userProfileUrl)

                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    "${widget.announcements.username}",
                    style: TextStyle(
                        color: oPrimaryColor, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            PopupMenuButton(itemBuilder: (context) {
              return [
              if(widget.announcements.creatorUid==_currentUid)PopupMenuItem(

                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => EditAnnouncementsPage());

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateAnnouncementsPage()));
                    },
                    child: Text(
                    "Update Announcements",
                    style: TextStyle(fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: oPrimaryColor),
                  ),
                ),
              ),
              ),

                if(widget.announcements.creatorUid==_currentUid) PopupMenuItem(


              child: GestureDetector(
              onTap:_deleteAnnouncements,
                child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text("Delete Announcements",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),),
                ),
              ),
              )
              ,

              ];
            },),
            // GestureDetector(onTap: (){_openBottomModalSheet(context);
            //   },child: const Icon(Icons.more_vert))
               ]),
            const SizedBox(height: 10,),
            Text('${widget.announcements.description}'),
            const SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.4,
              child: profileWidget(imageUrl: "${widget.announcements.announcementsImageUrl}"),
            ),
          ],
        ),
      ),
    );
  }

  _openBottomModalSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "More Options",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: oPrimaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      thickness: 1,
                      color: oSecondaryColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        child: Text(
                          "Delete Announcements",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: oPrimaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 7,),
                    Divider(
                      thickness: 1,
                      color: oSecondaryColor,
                    ),
                    SizedBox(height: 7,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => EditAnnouncementsPage());

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateAnnouncementsPage()));
                        },
                        child: Text(
                          "Update Announcements",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: oPrimaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 7,),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _deleteAnnouncements() {
    BlocProvider.of<AnnouncementCubit>(context)
        .deleteAnnouncements(announcements: AnnouncementsEntity(announcementsId: widget.announcements.announcementsId));
  }

  _likeAnnouncements() {
    BlocProvider.of<AnnouncementCubit>(context)
        .likeAnnouncements(announcements: AnnouncementsEntity(announcementsId: widget.announcements.announcementsId));
  }
}