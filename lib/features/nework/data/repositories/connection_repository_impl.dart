import 'package:uni_link/features/nework/data/data_sources/connection_data_source.dart';
import 'package:uni_link/features/nework/domain/repositories/connection_repository.dart';
import 'package:uni_link/features/user/domain/user_entity/user_entity.dart';

class ConnectionRepositoryImpl implements ConnectionRepository{
 final ConnectionDataSrc remoteDataSource;
  ConnectionRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> followUnFollowUser(UserEntity user) async => remoteDataSource.followUnFollowUser(user);
}