import 'package:uni_link/features/user/domain/repositories/user_repository.dart';

import '../../../app/domain/repositories/firebase_repository.dart';
import '../../user_entity/user_entity.dart';

class GetSingleOtherUserUseCase {
  final UserRepository repository;

  GetSingleOtherUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String otherUid) {
    return repository.getSingleOtherUser(otherUid);
  }
}