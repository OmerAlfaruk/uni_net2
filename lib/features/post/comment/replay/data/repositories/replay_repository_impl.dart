import 'package:uni_link/features/post/comment/replay/data/data_sources/replay_remote_data_src.dart';
import 'package:uni_link/features/post/comment/replay/domain/entities/replay_entity.dart';
import 'package:uni_link/features/post/comment/replay/domain/repositories/replay_repository.dart';

class ReplayRepositoryImpl implements ReplayRepository{
 final ReplayRemoteDataSrc remoteDataSource;

 ReplayRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> createReplay(ReplayEntity replay) async => remoteDataSource.createReplay(replay);

  @override
  Future<void> deleteReplay(ReplayEntity replay) async => remoteDataSource.deleteReplay(replay);

  @override
  Future<void> likeReplay(ReplayEntity replay) async => remoteDataSource.likeReplay(replay);

  @override
  Stream<List<ReplayEntity>> readReplays(ReplayEntity replay) => remoteDataSource.readReplays(replay);

  @override
  Future<void> updateReplay(ReplayEntity replay) async => remoteDataSource.updateReplay(replay);


}