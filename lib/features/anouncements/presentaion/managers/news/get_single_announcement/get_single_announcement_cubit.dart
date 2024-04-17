import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';
import 'package:uni_link/features/anouncements/domain/use_cases/read_single_annoncements_usecase.dart';
part 'get_single_announcement_state.dart';
class GetSingleAnnouncementCubit extends Cubit<GetSingleAnnouncementState> {
  final ReadSingleAnnouncementsUseCase readSingleAnnouncementUseCase;
  GetSingleAnnouncementCubit({required this.readSingleAnnouncementUseCase}) : super(GetSingleAnnouncementInitial());

  Future<void> getSingleAnnouncement({required String announcementsId}) async {
    emit(GetSingleAnnouncementLoading());
    try {
      final streamResponse = readSingleAnnouncementUseCase.call(announcementsId);
      streamResponse.listen((announcements) {
        emit(GetSingleAnnouncementLoaded(announcement: announcements.first));
      });
    } on SocketException catch(_) {
      emit(GetSingleAnnouncementFailure());
    } catch (_) {
      emit(GetSingleAnnouncementFailure());
    }
  }
}
