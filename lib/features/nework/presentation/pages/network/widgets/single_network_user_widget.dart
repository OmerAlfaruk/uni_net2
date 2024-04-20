
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/constant/color.dart';
import 'package:uni_link/features/presentation/widgets/button_container_widget.dart';
import 'package:uni_link/features/profile/presentation/manager/get_single_other_user_cubit.dart';
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';
import 'package:uni_link/features/user/presentation/manager/user/user_cubit/user/user_cubit.dart';
import '../../../../../../constant/image_string.dart';





class SingleNetworkUserWidget extends StatefulWidget {
  final String otherUserId;
  const SingleNetworkUserWidget({super.key, required this.otherUserId,  });

  @override
  State<SingleNetworkUserWidget> createState() => _SingleNetworkUserWidgetState();
}

class _SingleNetworkUserWidgetState extends State<SingleNetworkUserWidget> {
  String _currentUid="";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleOtherUserCubit, GetSingleOtherUserState>(
        builder: (context, userState) {
      if (userState is GetSingleOtherUserLoaded) {
        final singleUser = userState.otherUser;
    return ListTile(
      leading: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle
                  ),
                  child: ClipRRect(borderRadius: BorderRadius.circular(100),child: Image.asset(profileImage, fit: BoxFit.cover,)),
                ),
      title:  Text("${singleUser.username}", maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium,),
      subtitle:
          Text("${singleUser.totalConnection} connection", maxLines: 2, overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.labelSmall,),

      trailing: singleUser.connections!.contains(_currentUid)?ButtonContainerWidget(
        text: "Un Connect",
        onTapListener: () {
          BlocProvider.of<UserCubit>(context).followUnFollowUser(
            user: UserEntity(
                uid: _currentUid,
                otherUid: widget.otherUserId
            ),
          );

        },
      ):ButtonContainerWidget(
        text: "Connect",
        onTapListener: () {
          BlocProvider.of<UserCubit>(context).followUnFollowUser(
            user: UserEntity(
                uid: _currentUid,
                otherUid: widget.otherUserId
            ),
          );

        },
      )

    );}
        return Center(child: CircularProgressIndicator());
  },
);

    // return Card(
    //   elevation: 3,
    //   child: Stack(
    //     children: [
    //       Column(
    //         children: [
    //           Container(
    //             width: double.infinity,
    //             height: 80,
    //             decoration: const BoxDecoration(
    //                 color: Colors.grey
    //             ),
    //
    //           ),
    //           const SizedBox(height: 60,),
    //            Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //             child: Text("Username", maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium,),
    //           ),
    //           const SizedBox(height: 5,),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //             child: Text("info", maxLines: 1, overflow: TextOverflow.ellipsis,   style: Theme.of(context).textTheme.bodySmall
    //           ),),
    //           const SizedBox(height: 10,),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 const Icon(Icons.group),
    //                 const SizedBox(width: 10,),
    //                 Expanded(child: Text(" mutual connections", maxLines: 2, overflow: TextOverflow.ellipsis,  style: Theme.of(context).textTheme.labelSmall,))
    //               ],
    //             ),
    //           ),
    //           const SizedBox(height: 10,),
    //           Expanded(
    //             child: Container(
    //
    //               width: double.infinity,
    //               height: 40,
    //               decoration: BoxDecoration(
    //                 border: Border.all(width: 1, color: oPrimaryColor),
    //                 borderRadius: BorderRadius.circular(20),
    //               ),
    //               child: const Center(
    //                 child: Text("Connect", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: oPrimaryColor),),
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //
    //       Align(
    //         alignment: Alignment.topCenter,
    //         child: Container(
    //           margin: const EdgeInsets.only(top: 20),
    //           width: 110,
    //           height: 110,
    //           decoration: const BoxDecoration(
    //               color: Colors.grey,
    //               shape: BoxShape.circle
    //           ),
    //           child: ClipRRect(borderRadius: BorderRadius.circular(60),child: Image.asset(profileImage, fit: BoxFit.cover,)),
    //         ),
    //       )
    //     ],
    //   ),
    // );

  }
}
