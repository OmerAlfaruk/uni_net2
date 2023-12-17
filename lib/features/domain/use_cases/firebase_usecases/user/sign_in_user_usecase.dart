


import 'package:uni_link/features/domain/entities/user/user_entity.dart';
import 'package:uni_link/features/domain/repositories/firebase_repository.dart';

class SignInUserUseCase {
  final FirebaseRepository repository;

  SignInUserUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.signInUser(userEntity);
  }
}