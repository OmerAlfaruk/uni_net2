import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/app/domain/entities/app_entity.dart';
import 'package:uni_link/features/news/domain/entities/news_entity.dart';
import 'package:uni_link/features/news/presentaion/managers/news/get_single_new/get_single_news_cubit.dart';
import 'package:uni_link/features/news/presentaion/managers/news/news_cubit.dart';
import 'package:uni_link/features/news/comment/presentation/pages/comment/comment_page.dart';
import 'package:uni_link/features/news/presentaion/pages/news/update_news_page.dart';
import 'package:uni_link/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:uni_link/injection_container.dart' as di;
import 'package:intl/intl.dart';
class NewsDetailMainWidget extends StatefulWidget {
  final String newsId;
  const NewsDetailMainWidget({Key? key, required this.newsId}) : super(key: key);

  @override
  State<NewsDetailMainWidget> createState() => _NewsDetailMainWidgetState();
}

class _NewsDetailMainWidgetState extends State<NewsDetailMainWidget> {

  String _currentUid = "";

  @override
  void initState() {

    BlocProvider.of<GetSingleNewsCubit>(context).getSingleNews(newsId: widget.newsId);

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

        title: Text("News Detail"),
      ),

      body: BlocBuilder<GetSingleNewsCubit, GetSingleNewsState>(
        builder: (context, getSingleNewsState) {
          if (getSingleNewsState is GetSingleNewsLoaded) {
            final singleNews = getSingleNewsState.news;
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
                                          imageUrl: singleNews.userProfileUrl)

                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Text(
                                  "${singleNews.username}",
                                  style: TextStyle(
                                      color: oPrimaryColor, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          PopupMenuButton(itemBuilder: (context) {
                            return [
                              if(singleNews.creatorUid==_currentUid)PopupMenuItem(

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

                              if(singleNews.creatorUid==_currentUid) PopupMenuItem(


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
                    Text('${singleNews.description}'),
                    const SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.4,
                      child: profileWidget(imageUrl: "${singleNews.newsImageUrl}"),
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
                                          singleNews.likes!.contains(_currentUid)
                                              ?
                                          Icons.thumb_up : Icons.thumb_up_alt_outlined,
                                          color: singleNews.likes!.contains(_currentUid)
                                              ? oPrimaryColor
                                              : Colors.blue,),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text('Like'),
                                    ],
                                  ),
                                  Text(
                                    "${singleNews.totalLikes} likes",

                                  ),
                                ],

                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() =>  CommentPage(appEntity: AppEntity(uid: _currentUid,newsId: singleNews.newsId),));
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
                                        "${singleNews.totalComments} comments",
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
                                singleNews.createAt!.toDate())}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
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
  _openBottomModalSheet(BuildContext context, NewsEntity news) {
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
                    onTap: _deleteNews,
                    child: Text(
                      "Delete News",
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
                      //Navigator.pushNamed(context, PageConst.updateNewsPage, arguments: news);
                      Get.to(()=>EditNewsPage());

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateNewsPage()));

                    },
                    child: Text(
                      "Update News",
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



  _deleteNews() {
    BlocProvider.of<NewsCubit>(context).deleteNews(news: NewsEntity(newsId: widget.newsId));
  }

  _likeNews() {
    BlocProvider.of<NewsCubit>(context).likeNews(news: NewsEntity(
        newsId: widget.newsId
    ));
  }
}

