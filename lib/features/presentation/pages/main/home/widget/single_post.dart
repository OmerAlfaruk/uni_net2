import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/image_string.dart';
import 'package:uni_link/features/presentation/pages/main/home/comment/comment_page.dart';
import 'package:uni_link/features/presentation/pages/main/post/update_post_page.dart';

class PostWidget extends StatelessWidget {
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
      },
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  profileImage, // Replace with your image URL
                  fit: BoxFit.cover,
                ),

            ),
            ),
            const SizedBox(width: 10,),
            const Text(
              "username",
              style: TextStyle(
                  color: oPrimaryColor, fontWeight: FontWeight.bold),
            )
          ],
        ),
            ),
            GestureDetector(onTap: (){_openBottomModalSheet(context);
              },child: const Icon(Icons.more_vert))]),
            const SizedBox(height: 10,),
           Container(
             width: double.infinity,
             height: MediaQuery.of(context).size.height*0.3,
             color: oDarkColor,
           ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Excited to share some updates! #LinkedIn #Flutter'),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.thumb_up_alt_outlined,color: oPrimaryColor),
                          SizedBox(width: 8.0),
                          Text('Like'),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.to(()=>const SingleCommentWidget());
                          },
                        child: const Row(
                          children: [
                            Icon(Icons.mode_comment_outlined,color: oPrimaryColor,),
                            SizedBox(width: 8.0),
                            Text('Comment'),
                          ],
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.send_outlined,color: oPrimaryColor),
                          SizedBox(width: 8.0),
                          Text('Send'),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    "total likes",
                    style: TextStyle(color: oPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "username",
                        style:
                        TextStyle(color: oPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "description",
                        style: TextStyle(color: oPrimaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  GestureDetector(
                      onTap: () {

                      },
                      child: const Text(
                        "View all comments",
                        style: TextStyle(color: Colors.grey),
                      )),
                  const Text(
                    "dd/MMM/yyy",
                    style: TextStyle( color: Colors.grey),
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
                          "Delete Post",
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
                          Get.to(()=>EditPostPage());

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));
                        },
                        child: Text(
                          "Update Post",
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
}