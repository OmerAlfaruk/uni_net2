import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_link/constant/const.dart';
import 'package:uni_link/features/anouncements/presentaion/managers/announcements_cubit.dart';
import 'package:uni_link/features/anouncements/presentaion/pages/widget/single_announcement.dart';

import 'package:uni_link/injection_container.dart' as di;

import '../../domain/entities/anouncements.dart';

class AnnouncementsPage extends StatelessWidget {
  const  AnnouncementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<AnnouncementCubit>(
          create: (context) => di.sl<AnnouncementCubit>()..getAnnouncements(announcements: AnnouncementsEntity()),
          child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
            builder: (context, announcementsState) {
              if (announcementsState is AnnouncementsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (announcementsState is AnnouncementsFailure) {
                toast("Some Failure occured while creating the announcements");
              }
              if (announcementsState is AnnouncementsLoaded) {
                return announcementsState.announcement.isEmpty
                    ? _noAnnouncementsYetWidget()
                    : ListView.builder(
                        itemCount: announcementsState.announcement.length,
                        itemBuilder: (context, index) {
                          final announcements = announcementsState.announcement[index];
                          return BlocProvider(
                            create: (context) => di.sl<AnnouncementCubit>(),
                            child: AnnouncementWidget(announcements: announcements),

                          );
                        },
                      );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  _noAnnouncementsYetWidget() {
    return Center(
      child: Text(
        "No Announcements Yet",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
