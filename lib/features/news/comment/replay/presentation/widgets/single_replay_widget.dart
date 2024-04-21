

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/news/comment/replay/domain/entities/replay_entity.dart';

import 'package:uni_link/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:uni_link/injection_container.dart'as di;
class SingleReplayWidget extends StatefulWidget {
  final ReplayEntity2 replay;
  final VoidCallback? onLongPressListener;
  final VoidCallback? onLikeClickListener;
  const SingleReplayWidget({Key? key, required this.replay, this.onLongPressListener, this.onLikeClickListener}) : super(key: key);

  @override
  State<SingleReplayWidget> createState() => _SingleReplayWidgetState();
}

class _SingleReplayWidgetState extends State<SingleReplayWidget> {

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
    return InkWell(
      onLongPress: widget.replay.creatorUid == _currentUid? widget.onLongPressListener : null,
      child: Container(
        margin: EdgeInsets.only(left: 10, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: profileWidget(imageUrl: widget.replay.userProfileUrl),
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
                        Text("${widget.replay.username}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: oPrimaryColor),),
                        GestureDetector(
                            onTap: widget.onLikeClickListener,
                            child: Icon(
                              widget.replay.likes!.contains(_currentUid)
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_alt_outlined,
                              size: 20,
                              color:oPrimaryColor
                            ))                      ],
                    ),
                    sizeVer(4),
                    Text("${widget.replay.description}", style: TextStyle(color:oPrimaryColor),),
                    sizeVer(4),
                    Text(
                      "${DateFormat("dd/MMM/yyy").format(widget.replay.createAt!.toDate())}",
                      style: TextStyle(color: oDarkColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
