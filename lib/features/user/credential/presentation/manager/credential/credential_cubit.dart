import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_link/features/user/domain/use_cases/sign_in_user_usecase.dart';
import 'package:uni_link/features/user/domain/use_cases/sign_up_user_usecase.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';

import '../../../../../../utils/connection/connectivity_manager.dart';
import '../../../../../../utils/popups/loaders.dart';

part 'credential_state.dart';


class CredentialCubit extends Cubit<CredentialState> {
  final SignInUserUseCase signInUserUseCase;
  final SignUpUseCase signUpUseCase;
  CredentialCubit({required this.signInUserUseCase, required this.signUpUseCase}) : super(CredentialInitial());

  Future<void> signInUser({required String email, required String password}) async {
    emit(CredentialLoading());
    try {
      // final isConnected=await NetworkManager.instance.isConnected();
      // if(!isConnected) return;
      await signInUserUseCase.call(UserEntity(email: email, password: password));
      emit(CredentialSuccess());
    } on SocketException catch(e) {
      Loader.errorSnackBar(title: 'oh Snap', message: e.toString());
      emit(CredentialFailure());
    } catch (e) {
      Loader.errorSnackBar(title: 'oh Snap', message: e.toString());
      emit(CredentialFailure());
    }
  }

  Future<void> signUpUser({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      // final isConnected=await NetworkManager.instance.isConnected();
      // if(!isConnected) return;
      await signUpUseCase.call(user);
      emit(CredentialSuccess());
    } on SocketException catch(e) {
      Loader.errorSnackBar(title: 'oh Snap', message: e.toString());
      emit(CredentialFailure());
    } catch (e) {
      Loader.errorSnackBar(title: 'oh Snap', message: e.toString());
      emit(CredentialFailure());
    }
  }
}

