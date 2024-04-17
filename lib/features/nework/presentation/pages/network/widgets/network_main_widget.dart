import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:uni_link/common_widget/profile_widget/profile_widget.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/nework/presentation/pages/network/widgets/single_network_user_widget.dart';
import 'package:uni_link/features/presentation/widgets/button_container_widget.dart';
import 'package:uni_link/features/profile/presentation/pages/single_user_profile_page.dart';
import 'package:uni_link/features/user/domain/use_cases/get_current_uid_usecase.dart';
import 'package:uni_link/features/user/user_cubit/user/user_cubit.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';
import 'package:uni_link/injection_container.dart'as di;

class NetworkMainWidget extends StatefulWidget {

  const NetworkMainWidget({super.key,});

  @override
  State<NetworkMainWidget> createState() => _NetworkMainWidgetState();
}

class _NetworkMainWidgetState extends State<NetworkMainWidget> {
  String _currentUid = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          final filterAllUsers =
          userState.users.where((user) => !user.connections!.contains(_currentUid)).toList();
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: filterAllUsers.length,
                  physics: ScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          onTap:  ()=>Get.to(()=>SingleUserProfilePage(otherUserId: "${filterAllUsers[index].uid}")),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: profileWidget(imageUrl: filterAllUsers[index].profileUrl),
                          ),
                        ),
                      ),
                      title: Text(
                        "${filterAllUsers[index].username}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      subtitle: Text(
                        "${filterAllUsers[index].totalConnection} connection",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      trailing: GestureDetector(
                        child: Container(
                          height: 20,
                          width: 70,
                          color: oPrimaryColor,
                          child: Center(child: Text("Connect")),
                        ),
                        onTap: () {
                          BlocProvider.of<UserCubit>(context).followUnFollowUser(
                            user: UserEntity(
                              uid: _currentUid,
                              otherUid: filterAllUsers[index].uid,
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers(user: UserEntity());
    super.initState();
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
  }
}

