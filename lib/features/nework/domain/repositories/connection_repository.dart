
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';

abstract class ConnectionRepository{
  Future<void> followUnFollowUser(UserEntity user);
}