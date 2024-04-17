import 'package:uni_link/features/nework/domain/repositories/connection_repository.dart';
import 'package:uni_link/features/user/user_entity/user_entity.dart';
class FollowUnFollowUseCase {
  final ConnectionRepository repository;

  FollowUnFollowUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.followUnFollowUser(user);
  }
}