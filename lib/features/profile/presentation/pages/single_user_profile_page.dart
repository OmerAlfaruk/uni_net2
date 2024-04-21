import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/features/post/presentation/manager/post/post_cubit.dart';
import 'package:uni_link/features/profile/presentation/manager/get_single_other_user_cubit.dart';
import 'package:uni_link/features/profile/presentation/pages/profile/widget/single_user_profile_main_widget.dart';
import 'package:uni_link/injection_container.dart'as di;

class SingleUserProfilePage extends StatelessWidget {
  final String otherUserId;

  const SingleUserProfilePage({Key? key, required this.otherUserId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostCubit>(
          create: (context) => di.sl<PostCubit>(),
        ),  BlocProvider<GetSingleOtherUserCubit>(
          create: (context) => di.sl<GetSingleOtherUserCubit>(),
        ),

      ],
      child: SingleUserProfileMainWidget(otherUserId: otherUserId),
    );
  }
}