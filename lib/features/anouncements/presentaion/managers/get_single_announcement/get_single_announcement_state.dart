part of 'get_single_announcement_cubit.dart';

abstract class GetSingleAnnouncementState extends Equatable {
  const GetSingleAnnouncementState();
}

class GetSingleAnnouncementInitial extends GetSingleAnnouncementState {
  @override
  List<Object> get props => [];
}

class GetSingleAnnouncementLoading extends GetSingleAnnouncementState {
  @override
  List<Object> get props => [];
}


class GetSingleAnnouncementLoaded extends GetSingleAnnouncementState {
  final AnnouncementsEntity announcement;

  GetSingleAnnouncementLoaded({required this.announcement});
  @override
  List<Object> get props => [announcement];
}

class GetSingleAnnouncementFailure extends GetSingleAnnouncementState {
  @override
  List<Object> get props => [];
}

