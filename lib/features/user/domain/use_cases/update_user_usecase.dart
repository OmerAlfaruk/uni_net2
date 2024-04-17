
import 'package:uni_link/features/user/domain/repositories/user_repository.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';

class UpdateUserUseCase {
  final UserRepository repository;

  UpdateUserUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.updateUser(userEntity);
  }
}