import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/profile/presentation/pages/single_user_profile_page.dart';
import 'package:uni_link/features/user/domain/use_cases/get_single_user_usecase.dart';
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';
import 'package:uni_link/injection_container.dart'as di;
class NetworkPage extends StatelessWidget {
  final UserEntity user;
  const NetworkPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text("Connection"),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: user.connections!.isEmpty? _noFollowersWidget() : ListView.builder(itemCount: user.connections!.length,itemBuilder: (context, index) {

                return StreamBuilder<List<UserEntity>>(
                    stream: di.sl<GetSingleUserUseCase>().call(user.connections![index]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData == false) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }
                      final singleUserData = snapshot.data!.first;
                      return  GestureDetector(
                        onTap: () {
                          Get.to(()=>SingleUserProfilePage(otherUserId: singleUserData.uid!,));

                        },
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: profileWidget(imageUrl: singleUserData.profileUrl),
                              ),
                            ),
                            sizeHor(10),
                            Text("${singleUserData.username}", style: TextStyle(color: oPrimaryColor, fontSize: 15, fontWeight: FontWeight.w600),)
                          ],
                        ),
                      );
                    }
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  _noFollowersWidget() {
    return Center(
      child: Text("No Connection", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
    );
  }
}
