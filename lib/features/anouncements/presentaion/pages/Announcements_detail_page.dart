import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/features/anouncements/presentaion/managers/announcements_cubit.dart';
import 'package:uni_link/features/anouncements/presentaion/managers/get_single_announcement/get_single_announcement_cubit.dart';
import 'package:uni_link/features/anouncements/presentaion/pages/sub_widget/news_detail_wedget.dart';
import 'package:uni_link/features/news/presentaion/managers/news/get_single_new/get_single_news_cubit.dart';
import 'package:uni_link/features/news/presentaion/managers/news/news_cubit.dart';
import 'package:uni_link/injection_container.dart' as di;


class AnnouncementsDetailPage extends StatelessWidget {
  final String announcementsId;
  const AnnouncementsDetailPage({Key? key, required this.announcementsId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetSingleAnnouncementCubit>(
          create: (context) => di.sl<GetSingleAnnouncementCubit>(),
        ),
        BlocProvider<AnnouncementCubit>(
          create: (context) => di.sl<AnnouncementCubit>(),
        ),
      ],
      child: AnnouncementsDetailMainWidget(announcementsId: announcementsId,),
    );
  }
}