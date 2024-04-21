import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_link/features/news/comment/replay/domain/entities/replay_entity.dart';
import 'package:uni_link/features/news/comment/replay/domain/use_cases/create_reply_usecase.dart';
import 'package:uni_link/features/news/comment/replay/domain/use_cases/delete_reply_usecase.dart';
import 'package:uni_link/features/news/comment/replay/domain/use_cases/like_replay_usecase.dart';
import 'package:uni_link/features/news/comment/replay/domain/use_cases/read_replays.dart';
import 'package:uni_link/features/news/comment/replay/domain/use_cases/update_replay_usecase.dart';
import 'package:uni_link/features/post/comment/replay/domain/entities/replay_entity.dart';

part 'replay_state.dart';

class NewsReplayCubit extends Cubit<NewsReplayState> {
  final CreateNewsReplayUseCase createReplayUseCase;
  final DeleteNewsReplayUseCase deleteReplayUseCase;
  final LikeNewsReplayUseCase likeReplayUseCase;
  final ReadNewsReplaysUseCase readReplaysUseCase;
  final UpdateNewsReplayUseCase updateReplayUseCase;
  NewsReplayCubit({
    required this.createReplayUseCase,
    required this.updateReplayUseCase,
    required this.readReplaysUseCase,
    required this.likeReplayUseCase,
    required this.deleteReplayUseCase
  }) : super(ReplayInitial());

  Future<void> getReplays({required ReplayEntity2 replay}) async {
    emit(ReplayLoading());
    try {
      final streamResponse = readReplaysUseCase.call(replay);
      streamResponse.listen((replays) {
        emit(ReplayLoaded(replays: replays));
      });
    } on SocketException catch(_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }

  Future<void> likeReplay({required ReplayEntity2 replay}) async {
    try {
      await likeReplayUseCase.call(replay);
    } on SocketException catch(_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }

  Future<void> createReplay({required ReplayEntity2 replay}) async {
    try {
      await createReplayUseCase.call(replay);
    } on SocketException catch(_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }

  Future<void> deleteReplay({required ReplayEntity2 replay}) async {
    try {
      await deleteReplayUseCase.call(replay);
    } on SocketException catch(_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }

  Future<void> updateReplay({required ReplayEntity2 replay}) async {
    try {
      await updateReplayUseCase.call(replay);
    } on SocketException catch(_) {
      emit(ReplayFailure());
    } catch (_) {
      emit(ReplayFailure());
    }
  }
}

