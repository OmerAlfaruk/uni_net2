import 'package:uni_link/features/user/domain/repositories/user_repository.dart';
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';

import '../../../app/domain/repositories/firebase_repository.dart';

class GetSingleOtherUserUseCase {
  final UserRepository repository;

  GetSingleOtherUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String otherUid) {
    return repository.getSingleOtherUser(otherUid);
  }
}