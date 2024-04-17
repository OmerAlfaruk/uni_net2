import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/features/anouncements/presentaion/managers/news/announcements_cubit.dart';
import 'package:uni_link/features/anouncements/presentaion/pages/news/widget/upload_announcements_main_widget.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';
import 'package:uni_link/injection_container.dart' as di;

class UploadAnnouncementPage extends StatelessWidget {
  final UserEntity currentUser;

  const UploadAnnouncementPage({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AnnouncementCubit>(
      create: (context) => di.sl<AnnouncementCubit>(),
      child: UploadAnnouncementsMainWidget(currentUser: currentUser),
    );
  }
}