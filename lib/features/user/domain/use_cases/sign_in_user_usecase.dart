



import 'package:uni_link/features/app/domain/repositories/firebase_repository.dart';
import 'package:uni_link/features/user/domain/repositories/user_repository.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';

class SignInUserUseCase {
  final UserRepository repository;

  SignInUserUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.signInUser(userEntity);
  }
}