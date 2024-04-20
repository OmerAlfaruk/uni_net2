part of 'announcements_cubit.dart';

abstract class AnnouncementState extends Equatable {
  const AnnouncementState();
}

class AnnouncementsInitial extends AnnouncementState {
  @override
  List<Object> get props => [];
}

class AnnouncementsLoading extends AnnouncementState {
  @override
  List<Object> get props => [];
}


class AnnouncementsLoaded extends AnnouncementState {
  final List<AnnouncementsEntity> announcement;

  AnnouncementsLoaded({required this.announcement});
  @override
  List<Object> get props => [announcement];
}


class AnnouncementsFailure extends AnnouncementState {
  @override
  List<Object> get props => [];
}
