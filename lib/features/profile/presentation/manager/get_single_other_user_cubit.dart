import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_link/features/user/domain/use_cases/get_other_single_user.dart';
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';

part 'get_single_other_user_state.dart';

class GetSingleOtherUserCubit extends Cubit<GetSingleOtherUserState> {
  final GetSingleOtherUserUseCase getSingleOtherUserUseCase;
  GetSingleOtherUserCubit({
    required this.getSingleOtherUserUseCase
  }) : super(GetSingleOtherUserInitial());

  Future<void> getSingleOtherUser({required String otherUid}) async {
    emit(GetSingleOtherUserLoading());
    try {
      final streamResponse = getSingleOtherUserUseCase.call(otherUid);
      streamResponse.listen((users) {
        emit(GetSingleOtherUserLoaded(otherUser: users.first));
      });
    } on SocketException catch(_) {
      emit(GetSingleOtherUserFailure());
    } catch (_) {
      emit(GetSingleOtherUserFailure());
    }
  }
}
