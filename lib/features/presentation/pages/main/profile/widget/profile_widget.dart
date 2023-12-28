import 'package:flutter/material.dart';
import 'package:uni_link/constant/image_string.dart';
import 'package:uni_link/features/domain/entities/user/user_entity.dart';

import '../../../../../../constant/color.dart';

class ProfileMainWidget extends StatefulWidget {
  const ProfileMainWidget({super.key, required this.currentUser});

  final UserEntity currentUser;

  @override
  State<ProfileMainWidget> createState() => _ProfileMainWidgetState();
}

class _ProfileMainWidgetState extends State<ProfileMainWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(profileImage),
                  ),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "${widget.currentUser.totalPosts}",
                          style: TextStyle(
                              color: oPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Posts",
                          style: TextStyle(color: oPrimaryColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            "${widget.currentUser.totalConnection}",
                            style: TextStyle(
                                color: oPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Connections",
                            style: TextStyle(color: oPrimaryColor),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${widget.currentUser.username}",
              style:
                  TextStyle(color: oPrimaryColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${widget.currentUser.university}",
              style: TextStyle(color: oPrimaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${widget.currentUser.bio}",
              style: TextStyle(color: oPrimaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.builder(
                itemCount: 32,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 100,
                      height: 100,
                      child: Image.asset(profileImage),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
