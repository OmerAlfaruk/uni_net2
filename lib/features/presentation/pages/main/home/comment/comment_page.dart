import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/presentation/widgets/form_container_widget.dart';

class SingleCommentWidget extends StatefulWidget {
  const SingleCommentWidget({super.key});

  @override
  State<SingleCommentWidget> createState() => _SingleCommentWidgetState();
}

class _SingleCommentWidgetState extends State<SingleCommentWidget> {

  TextEditingController _replayDescriptionController = TextEditingController();
  bool _isUserReplaying=false;
  @override
  Widget build(BuildContext context) {
    bool isDak=MediaQuery.of(context).platformBrightness==Brightness.dark;
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Get.back(); },color: oPrimaryColor,), title: const Text('Comments',style: TextStyle(color: oPrimaryColor),),elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(width: 10,),

                 Divider(color: oSecondaryColor,),

                SizedBox(width: 10,),
                Expanded(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "username",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),



                  ])
                ),
              ],
            ),
          ),

          SizedBox(height: 4,),
          Row(
            children: [
              SizedBox(width: 10,),
              Text(
                "Comments",
                style: TextStyle(),
              ),
            ],
          ),
          Expanded(
            child: Container(
               margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
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
                                "username",
                                style: Theme.of(context).textTheme.bodyMedium),
                              GestureDetector(
                                  onTap: (){},
                                  child: Icon(

                                        Icons.thumb_up_alt_outlined,
                                    size: 20,
                                    color: Colors.grey[800],
                                  ))
                            ],
                          ),
                          SizedBox(height: 4,),
                          Text(
                            "description",
                            style: TextStyle(color: oPrimaryColor),
                          ),
                          SizedBox(height: 4,),
                          Row(
                            children: [
                              Text(
                                "dd/MMM/yyy",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                              SizedBox(width: 15,),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isUserReplaying = !_isUserReplaying;
                                    });
                                  },
                                  child: Text(
                                    "Replay",
                                    style: TextStyle(color: Colors.grey[800], fontSize: 12),
                                  )),
                        SizedBox(width: 15,),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "View Replays",
                                  style: TextStyle(color: Colors.grey[800], fontSize: 12),
                                ),
                              ),
                            ],
                          ),

                          _isUserReplaying == true ? SizedBox(height: 10,): SizedBox(height: 0,),
                          _isUserReplaying == true
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FormContainerWidget(
                                  hintText: "Post your replay...",
                                  controller: _replayDescriptionController
                              ),
                              SizedBox(height: 10,),
                              GestureDetector(
                                onTap: () {
                                },
                                child: Text(
                                  "Post",
                                  style: TextStyle(color: oPrimaryColor),
                                ),
                              )
                            ],
                          )
                              : const SizedBox(
                            width: 0,
                            height: 0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _commentSection(),
        ],
      ),
    );
  }
  _commentSection() {
    bool isDak=MediaQuery.of(context).platformBrightness==Brightness.dark;
    return Container(
      width: double.infinity,
      height: 55,
      color: isDak?Colors.grey[800]:Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: profileWidget(),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
                child: TextFormField(

                  style: TextStyle(color: oPrimaryColor),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Post your comment...",
                      hintStyle: TextStyle(color: oSecondaryColor)),
                )),
            GestureDetector(
                onTap: () {

                },
                child: Text(
                  "Post",
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ))
          ],
        ),
      ),
    );
  }

//   _openBottomModalSheet({required BuildContext context, required ReplayEntity replay}) {
//     return showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return Container(
//             height: 150,
//             decoration: BoxDecoration(color: backGroundColor.withOpacity(.8)),
//             child: SingleChildScrollView(
//               child: Container(
//                 margin: EdgeInsets.symmetric(vertical: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: Text(
//                         "More Options",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 18, color: primaryColor),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Divider(
//                       thickness: 1,
//                       color: secondaryColor,
//                     ),
//                     SizedBox(
//                       height: 8,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: GestureDetector(
//                         onTap: () {
//
//                         },
//                         child: Text(
//                           "Delete Replay",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500, fontSize: 16, color: primaryColor),
//                         ),
//                       ),
//                     ),
//                     sizeVer(7),
//                     Divider(
//                       thickness: 1,
//                       color: secondaryColor,
//                     ),
//                     sizeVer(7),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, PageConst.updateReplayPage,
//                               arguments: replay);
//
//                           // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
//                         },
//                         child: Text(
//                           "Update Replay",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500, fontSize: 16, color: primaryColor),
//                         ),
//                       ),
//                     ),
//                     sizeVer(7),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
//
//
}
