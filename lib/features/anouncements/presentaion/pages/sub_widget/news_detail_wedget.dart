import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';
import 'package:uni_link/features/anouncements/presentaion/managers/announcements_cubit.dart';
import 'package:uni_link/features/anouncements/presentaion/managers/get_single_announcement/get_single_announcement_cubit.dart';
import 'package:uni_link/features/anouncements/presentaion/pages/update_announcements_page.dart';
import 'package:uni_link/features/app/domain/entities/app_entity.dart';
import 'package:uni_link/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:uni_link/injection_container.dart' as di;
import 'package:intl/intl.dart';
class AnnouncementsDetailMainWidget extends StatefulWidget {
  final String announcementsId;
  const AnnouncementsDetailMainWidget({Key? key, required this.announcementsId}) : super(key: key);

  @override
  State<AnnouncementsDetailMainWidget> createState() => _AnnouncementsDetailMainWidgetState();
}

class _AnnouncementsDetailMainWidgetState extends State<AnnouncementsDetailMainWidget> {

  String _currentUid = "";

  @override
  void initState() {

    BlocProvider.of<GetSingleAnnouncementCubit>(context).getSingleAnnouncement(announcementsId: widget.announcementsId);

    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }

  bool _isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Announcements Detail"),
      ),

      body: BlocBuilder<GetSingleAnnouncementCubit, GetSingleAnnouncementState>(
        builder: (context, getSingleAnnouncementsState) {
          if (getSingleAnnouncementsState is GetSingleAnnouncementLoaded) {
            final singleAnnouncements = getSingleAnnouncementsState.announcement;
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
                            onTap: () {},
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,

                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: profileWidget(
                                          imageUrl: singleAnnouncements.userProfileUrl)

                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Text(
                                  "${singleAnnouncements.username}",
                                  style: TextStyle(
                                      color: oPrimaryColor, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          PopupMenuButton(itemBuilder: (context) {
                            return [
                              if(singleAnnouncements.creatorUid==_currentUid)PopupMenuItem(

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

                              if(singleAnnouncements.creatorUid==_currentUid) PopupMenuItem(


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
                    Text('${singleAnnouncements.description}'),
                    const SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.4,
                      child: profileWidget(imageUrl: "${singleAnnouncements.announcementsImageUrl}"),
                    ),
                  ],
                ),
              ),
            );;

          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
  _openBottomModalSheet(BuildContext context, AnnouncementsEntity announcements) {
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "More Options",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: oPrimaryColor),
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
                    onTap: _deleteAnnouncements,
                    child: Text(
                      "Delete Announcements",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),
                    ),
                  ),
                ),
                sizeVer(7),
                Divider(
                  thickness: 1,
                  color: oSecondaryColor,
                ),
                sizeVer(7),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      //Navigator.pushNamed(context, PageConst.updateAnnouncementsPage, arguments: announcements);
                      Get.to(()=>EditAnnouncementsPage());

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateAnnouncementsPage()));

                    },
                    child: Text(
                      "Update Announcements",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),
                    ),
                  ),
                ),
                sizeVer(7),
              ],
            ),
          ),
        ),
      );
    });
  }



  _deleteAnnouncements() {
    BlocProvider.of<AnnouncementCubit>(context).deleteAnnouncements(announcements: AnnouncementsEntity(announcementsId: widget.announcementsId));
  }

  _likeAnnouncements() {
    BlocProvider.of<AnnouncementCubit>(context).likeAnnouncements(announcements: AnnouncementsEntity(
        announcementsId: widget.announcementsId
    ));
  }
}

