
import 'package:uni_link/features/news/comment/replay/data/data_sources/replay_remote_data_src.dart';
import 'package:uni_link/features/news/comment/replay/domain/entities/replay_entity.dart';
import 'package:uni_link/features/news/comment/replay/domain/repositories/replay_repository.dart';

class NewsReplayRepositoryImpl implements NewsReplayRepository{
 final NewsReplayRemoteDataSrc remoteDataSource;

 NewsReplayRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> createReplay(ReplayEntity2 replay) async => remoteDataSource.createReplay(replay);

  @override
  Future<void> deleteReplay(ReplayEntity2 replay) async => remoteDataSource.deleteReplay(replay);

  @override
  Future<void> likeReplay(ReplayEntity2 replay) async => remoteDataSource.likeReplay(replay);

  @override
  Stream<List<ReplayEntity2>> readReplays(ReplayEntity2 replay) => remoteDataSource.readReplays(replay);

  @override
  Future<void> updateReplay(ReplayEntity2 replay) async => remoteDataSource.updateReplay(replay);


}