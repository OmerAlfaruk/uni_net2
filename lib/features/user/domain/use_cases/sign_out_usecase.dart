




import 'package:uni_link/features/app/domain/repositories/firebase_repository.dart';
import 'package:uni_link/features/user/domain/repositories/user_repository.dart';

class SignOutUseCase {
  final UserRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() {
    return repository.signOut();
  }
}