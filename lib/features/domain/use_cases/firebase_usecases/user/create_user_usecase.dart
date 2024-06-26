


import 'package:uni_link/features/domain/entities/user/user_entity.dart';
import 'package:uni_link/features/domain/repositories/firebase_repository.dart';

class CreateUserUseCase {
  final FirebaseRepository repository;

  CreateUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}