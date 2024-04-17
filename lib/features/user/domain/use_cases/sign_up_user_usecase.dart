



import 'package:uni_link/features/user/domain/repositories/user_repository.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';

class SignUpUseCase {
  final UserRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.signUpUser(userEntity);
  }
}