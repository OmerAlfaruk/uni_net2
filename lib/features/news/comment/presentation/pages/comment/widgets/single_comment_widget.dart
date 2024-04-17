import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/news/comment/domain/entities/comment_entity.dart';
import 'package:uni_link/features/news/comment/replay/domain/entities/replay_entity.dart';
import 'package:uni_link/features/news/comment/replay/presentation/manager/replay/replay_cubit.dart';
import 'package:uni_link/features/news/comment/replay/presentation/widgets/single_replay_widget.dart';

import 'package:uni_link/features/presentation/widgets/form_container_widget.dart';
import 'package:uni_link/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';
import 'package:uni_link/injection_container.dart' as di;
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class SingleCommentWidget extends StatefulWidget {
  final CommentEntity comment;
  final VoidCallback? onLongPressListener;
  final VoidCallback? onLikeClickListener;
  final UserEntity? currentUser;

  const SingleCommentWidget(
      {Key? key,
      required this.comment,
      this.onLongPressListener,
      this.onLikeClickListener,
      this.currentUser})
      : super(key: key);

  @override
  State<SingleCommentWidget> createState() => _SingleCommentWidgetState();
}

class _SingleCommentWidgetState extends State<SingleCommentWidget> {
  TextEditingController _replayDescriptionController = TextEditingController();
  String _currentUid = "";

  @override
  void initState() {
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });

    BlocProvider.of<NewsReplayCubit>(context).getReplays(
        replay: ReplayEntity2(
            newsId: widget.comment.newsId,
            commentId: widget.comment.commentId));

    super.initState();
  }

  bool _isUserReplaying = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.comment.creatorUid == _currentUid
          ? widget.onLongPressListener
          : null,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: profileWidget(imageUrl: widget.comment.userProfileUrl),
              ),
            ),
            sizeHor(10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.comment.username}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                            onTap: widget.onLikeClickListener,
                            child: Icon(
                                widget.comment.likes!.contains(_currentUid)
                                    ? Icons.thumb_up
                                    : Icons.thumb_up_alt_outlined,
                                size: 20,
                                color: oPrimaryColor))
                      ],
                    ),
                    sizeVer(4),
                    Text(
                      "${widget.comment.description}",
                      style: TextStyle(),
                    ),
                    sizeVer(4),
                    Row(
                      children: [
                        Text(
                          "${DateFormat("dd/MMM/yyy").format(widget.comment.createAt!.toDate())}",
                          style: TextStyle(color: Colors.grey),
                        ),
                        sizeHor(15),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                _isUserReplaying = !_isUserReplaying;
                              });
                            },
                            child: Text(
                              "Replay",
                              style: TextStyle(color: Colors.grey),
                            )),
                        sizeHor(15),
                        GestureDetector(
                          onTap: () {
                            widget.comment.totalReplays == 0
                                ? toast("no replays")
                                : BlocProvider.of<NewsReplayCubit>(context)
                                    .getReplays(
                                        replay: ReplayEntity2(
                                            newsId: widget.comment.newsId,
                                            commentId:
                                                widget.comment.commentId));
                          },
                          child: Text(
                            "View Replays",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<NewsReplayCubit, NewsReplayState>(
                      builder: (context, replayState) {
                        if (replayState is ReplayLoaded) {
                          final replays = replayState.replays
                              .where((element) =>
                                  element.commentId == widget.comment.commentId)
                              .toList();
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: replays.length,
                              itemBuilder: (context, index) {
                                return SingleReplayWidget(
                                  replay: replays[index],
                                  onLongPressListener: () {
                                    widget.comment.creatorUid == _currentUid
                                        ? _openBottomModalSheet(
                                            context: context,
                                            replay: replays[index])
                                        : null;
                                  },
                                  onLikeClickListener: () {
                                    _likeReplay(replay: replays[index]);
                                  },
                                );
                              });
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    _isUserReplaying == true ? sizeVer(10) : sizeVer(0),
                    _isUserReplaying == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FormContainerWidget(
                                  hintText: "Post your replay...",
                                  controller: _replayDescriptionController),
                              sizeVer(10),
                              GestureDetector(
                                onTap: () {
                                  _createReplay();
                                },
                                child: Text(
                                  "Post",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                            ],
                          )
                        : Container(
                            width: 0,
                            height: 0,
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createReplay() {
    BlocProvider.of<NewsReplayCubit>(context)
        .createReplay(
            replay: ReplayEntity2(
      replayId: Uuid().v1(),
      createAt: Timestamp.now(),
      likes: [],
      username: widget.currentUser!.username,
      userProfileUrl: widget.currentUser!.profileUrl,
      creatorUid: widget.currentUser!.uid,
      newsId: widget.comment.newsId,
      commentId: widget.comment.commentId,
      description: _replayDescriptionController.text,
    ))
        .then((value) {
      setState(() {
        _replayDescriptionController.clear();
        _isUserReplaying = false;
      });
    });
  }

  _openBottomModalSheet(
      {required BuildContext context, required ReplayEntity2 replay}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            decoration: BoxDecoration(color: oDarkColor),
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
                        onTap: () {
                          _deleteReplay(replay: replay);
                        },
                        child: Text(
                          "Delete Replay",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: oPrimaryColor),
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
                          Navigator.pushNamed(
                              context, PageConst.updateReplayPage,
                              arguments: replay);

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
                        },
                        child: Text(
                          "Update Replay",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: oPrimaryColor),
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

  _deleteReplay({required ReplayEntity2 replay}) {
    BlocProvider.of<NewsReplayCubit>(context).deleteReplay(
        replay: ReplayEntity2(
            newsId: replay.newsId,
            commentId: replay.commentId,
            replayId: replay.replayId));
  }

  _likeReplay({required ReplayEntity2 replay}) {
    BlocProvider.of<NewsReplayCubit>(context).likeReplay(
        replay: ReplayEntity2(
            newsId: replay.newsId,
            commentId: replay.commentId,
            replayId: replay.replayId));
  }
}
