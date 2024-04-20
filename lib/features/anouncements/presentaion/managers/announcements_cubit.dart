import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_link/features/anouncements/domain/entities/anouncements.dart';
import 'package:uni_link/features/anouncements/domain/use_cases/create_announcements_usecase.dart';
import 'package:uni_link/features/anouncements/domain/use_cases/delete_announcements_usecase.dart';
import 'package:uni_link/features/anouncements/domain/use_cases/like_announcement_usecase.dart';
import 'package:uni_link/features/anouncements/domain/use_cases/read_announcement_usecase.dart';
import 'package:uni_link/features/anouncements/domain/use_cases/update_announcements_usecase.dart';
import 'package:uni_link/features/news/domain/use_cases/create_news_usecase.dart';
import 'package:uni_link/features/news/domain/use_cases/delete_news_usecase.dart';
import 'package:uni_link/features/news/domain/use_cases/like_news_usecase.dart';
import 'package:uni_link/features/news/domain/use_cases/read_news_usecase.dart';
import 'package:uni_link/features/news/domain/use_cases/update_news_usecase.dart';

part 'announcements_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  final CreateAnnouncementsUseCase createAnnouncementsUseCase;
  final DeleteAnnouncementsUseCase deleteAnnouncementsUseCase;
  final LikeAnnouncementsUseCase likeAnnouncementsUseCase;
  final ReadAnnouncementsUseCase readAnnouncementsUseCase;
  final UpdateAnnouncementUseCase updateAnnouncementsUseCase;
  AnnouncementCubit({
    required this.updateAnnouncementsUseCase,
    required this.deleteAnnouncementsUseCase,
    required this.likeAnnouncementsUseCase,
    required this.createAnnouncementsUseCase,
    required this.readAnnouncementsUseCase
  }) : super(AnnouncementsInitial());

  Future<void> getAnnouncements({required AnnouncementsEntity announcements}) async {
    emit(AnnouncementsLoading());
    try {
      final streamResponse = readAnnouncementsUseCase.call(announcements);
      streamResponse.listen((announcements) {
        emit(AnnouncementsLoaded(announcement:announcements));
      });
    } on SocketException catch(_) {
      emit(AnnouncementsFailure());
    } catch (_) {
      emit(AnnouncementsFailure());
    }
  }

  Future<void> likeAnnouncements({required AnnouncementsEntity announcements}) async {
    try {
      await likeAnnouncementsUseCase.call(announcements);
    } on SocketException catch(_) {
      emit(AnnouncementsFailure());
    } catch (_) {
      emit(AnnouncementsFailure());
    }
  }

  Future<void> deleteAnnouncements({required AnnouncementsEntity announcements}) async {
    try {
      await deleteAnnouncementsUseCase.call(announcements);
    } on SocketException catch(_) {
      emit(AnnouncementsFailure());
    } catch (_) {
      emit(AnnouncementsFailure());
    }
  }

  Future<void> createAnnouncements({required AnnouncementsEntity announcements}) async {
    try {
      await createAnnouncementsUseCase.call(announcements);
    } on SocketException catch(_) {
      emit(AnnouncementsFailure());
    } catch (_) {
      emit(AnnouncementsFailure());
    }
  }

  Future<void> updateAnnouncements({required AnnouncementsEntity announcements}) async {
    try {
      await updateAnnouncementsUseCase.call(announcements);
    } on SocketException catch(_) {
      emit(AnnouncementsFailure());
    } catch (_) {
      emit(AnnouncementsFailure());
    }
  }}
