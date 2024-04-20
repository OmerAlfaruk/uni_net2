import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/anouncements/presentaion/pages/announcements.dart';
import 'package:uni_link/features/chat/presentation/pages/chat/all_chat.dart';
import 'package:uni_link/features/chat/presentation/pages/chat/chat_page.dart';
import 'package:uni_link/features/event/presentation/pages/event_screen/event_page.dart';
import 'package:uni_link/features/nework/presentation/pages/network/network.dart';
import 'package:uni_link/features/nework/presentation/pages/network/widgets/single_network_user_widget.dart';
import 'package:uni_link/features/news/presentaion/pages/news.dart';
import 'package:uni_link/features/post/presentation/pages/home/post.dart';
import 'package:uni_link/features/post/presentation/pages/home/widget/tab_bar.dart';
import 'package:uni_link/features/profile/presentation/pages/profile/profile.dart';
import 'package:uni_link/features/search/presentation/pages/search/search.dart';
import 'package:uni_link/features/user/presentation/manager/user/user_cubit/user/get_single_user/get_single_user_cubit.dart';
import '../../common_widget/grid_layout/o_gridLaout.dart';
import '../../utils/helpers/helper_functions.dart';
import '../nework/presentation/pages/network/widgets/network_main_widget.dart';
import '../presentation/widgets/appbar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserState) {
        if (getSingleUserState is GetSingleUserLoaded) {
          final currentUser = getSingleUserState.user;
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: Padding(

                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(ProfilePage(currentUser: currentUser));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: profileWidget(
                          imageUrl: currentUser.profileUrl
                      ),),),
                ),
                actions: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SearchPage());
                        },
                        child: Icon(Icons.search,),
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
                         Get.to(() =>AllContact());
                        }, ammount: '13',
                      ),
                    ],
                  )

                ],
              ),


              body: NestedScrollView(
                headerSliverBuilder: (_, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      floating: true,
                      expandedHeight: 440,
                      backgroundColor: OHelperFunctions.isDark(context)
                          ? blackColor
                          : whiteColor,
                      flexibleSpace: Padding(
                          padding: const EdgeInsets.all(16),
                          child: NetworkMainWidget()
                      ),

                      /// Tabs
                      bottom: const OTabBar(
                        tabs: [
                          Tab(
                            child: Text('Post'),
                          ),
                          Tab(
                            child: Text('News'),
                          ),
                          Tab(
                            child: Text('Announcements'),
                          ),

                        ],
                      ),
                    )
                  ];
                },

                /// body
                body: TabBarView(
                  children: [
                    PostPage(),
                    NewsPage(),
                    AnnouncementsPage()
                  ],
                ),
              ),
            ),
          );
        }
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Padding(

                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: profileWidget(

                    ),),),
              ),
              actions: [
    BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
    builder: (context, getSingleUserState) {
    if (getSingleUserState is GetSingleUserLoaded) {
    final currentUser = getSingleUserState.user;
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SearchPage());
                          },
                          child: Icon(Icons.search,),
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
                            Get.to(() =>  AllContact());
                          }, ammount: '13',
                        ),
                      ],
                    );
                  }
    return Container();},
                )

              ],
            ),


            body: NestedScrollView(
              headerSliverBuilder: (_, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    expandedHeight: 440,
                    backgroundColor: OHelperFunctions.isDark(context)
                        ? blackColor
                        : whiteColor,
                    flexibleSpace: Padding(
                        padding: const EdgeInsets.all(16),
                        child: NetworkMainWidget()
                    ),

                    /// Tabs
                    bottom: const OTabBar(
                      tabs: [
                        Tab(
                          child: Text('Post'),
                        ),
                        Tab(
                          child: Text('News'),
                        ),
                        Tab(
                          child: Text('Announcements'),
                        ),

                      ],
                    ),
                  )
                ];
              },

              /// body
              body: TabBarView(
                children: [
                  PostPage(),
                  NewsPage(),
                  AnnouncementsPage()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
