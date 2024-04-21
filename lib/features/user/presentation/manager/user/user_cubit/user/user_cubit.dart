import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_link/features/nework/domain/use_cases/connection_usecase.dart';
import 'package:uni_link/features/user/domain/use_cases/get_users_usecase.dart';
import 'package:uni_link/features/user/domain/use_cases/update_user_usecase.dart';
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UpdateUserUseCase updateUserUseCase;
  final GetUsersUseCase getUsersUseCase;
  final FollowUnFollowUseCase followUnFollowUseCase;
  UserCubit({required this.updateUserUseCase, required this.getUsersUseCase,required this.followUnFollowUseCase}) : super(UserInitial());
  Future<void> getUsers({required UserEntity user}) async {
    emit(UserLoading());
    try {
      final streamResponse = getUsersUseCase.call(user);
      streamResponse.listen((users) {
        emit(UserLoaded(users: users));
      });
    } on SocketException catch(_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> updateUser({required UserEntity user}) async {
    try {
      await updateUserUseCase.call(user);
    } on SocketException catch(_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
  Future<void> followUnFollowUser({required UserEntity user}) async {
    try {
      await followUnFollowUseCase.call(user);
    } on SocketException catch(_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
