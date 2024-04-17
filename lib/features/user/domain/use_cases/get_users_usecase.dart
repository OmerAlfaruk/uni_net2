






import 'package:uni_link/features/user/domain/repositories/user_repository.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase({required this.repository});

  Stream<List<UserEntity>> call(UserEntity userEntity) {
    return repository.getUsers(userEntity);
  }
}