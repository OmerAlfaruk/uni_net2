import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/image_string.dart';
import 'package:uni_link/features/app/domain/entities/app_entity.dart';
import 'package:uni_link/features/news/presentaion/managers/news/news_cubit.dart';
import 'package:uni_link/features/news/comment/presentation/pages/comment/comment_page.dart';
import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:intl/intl.dart';
import 'package:uni_link/features/news/presentaion/pages/update_news_page.dart';
import 'package:uni_link/features/profile/presentation/pages/profile/profile.dart';
import 'package:uni_link/features/profile/presentation/pages/single_user_profile_page.dart';
import 'package:uni_link/features/user/domain/use_cases/get_current_uid_usecase.dart';



import 'package:uni_link/injection_container.dart'as di;

class NewsWidget extends StatefulWidget {
  final NewsEntity news;

  const NewsWidget({super.key, required this.news});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
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
                Get.to(SingleUserProfilePage(otherUserId:'${widget.news.creatorUid}'),);

              },
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,

                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: profileWidget(
                            imageUrl: widget.news.userProfileUrl)

                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    "${widget.news.username}",
                    style: TextStyle(
                        color: oPrimaryColor, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            PopupMenuButton(itemBuilder: (context) {
              return [
              if(widget.news.creatorUid==_currentUid)PopupMenuItem(

                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => EditNewsPage());

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateNewsPage()));
                    },
                    child: Text(
                    "Update News",
                    style: TextStyle(fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: oPrimaryColor),
                  ),
                ),
              ),
              ),

                if(widget.news.creatorUid==_currentUid) PopupMenuItem(


              child: GestureDetector(
              onTap:_deleteNews,
                child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text("Delete News",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: oPrimaryColor),),
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
            Text('${widget.news.description}'),
            const SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.4,
              child: profileWidget(imageUrl: "${widget.news.newsImageUrl}"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: _likeNews,
                                child: Icon(
                                  widget.news.likes!.contains(_currentUid)
                                      ?
                                Icons.thumb_up : Icons.thumb_up_alt_outlined,
                                   color: widget.news.likes!.contains(_currentUid)
                                    ? oPrimaryColor
                                    : Colors.blue,),
                              ),
                              SizedBox(width: 8.0),
                              Text('Like'),
                            ],
                          ),
                          Text(
                            "${widget.news.totalLikes} likes",

                          ),
                        ],

                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() =>  CommentPage(appEntity: AppEntity(uid: _currentUid,newsId: widget.news.newsId),));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.mode_comment_outlined,
                                  color: oPrimaryColor,),
                                SizedBox(width: 8.0),
                                Text('Comment'),
                              ],
                            ),
                          ),

                          GestureDetector(
                              onTap: () {

                              },
                              child: Text(
                                "${widget.news.totalComments} comments",
                                style: TextStyle(color: Colors.grey),
                              )),
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(Icons.send_outlined, color: oPrimaryColor),
                          SizedBox(width: 8.0),
                          Text('Send'),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 10,),
                  Text(
                    "${ DateFormat("dd/MMM/yyy").format(
                        widget.news.createAt!.toDate())}",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
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
                          "Delete News",
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
                          Get.to(() => EditNewsPage());

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateNewsPage()));
                        },
                        child: Text(
                          "Update News",
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

  _deleteNews() {
    BlocProvider.of<NewsCubit>(context)
        .deleteNews(news: NewsEntity(newsId: widget.news.newsId));
  }

  _likeNews() {
    BlocProvider.of<NewsCubit>(context)
        .likeNews(news: NewsEntity(newsId: widget.news.newsId));
  }
}