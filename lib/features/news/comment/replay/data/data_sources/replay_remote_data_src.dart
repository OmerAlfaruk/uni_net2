

import 'package:uni_link/features/news/comment/replay/domain/entities/replay_entity.dart';

abstract class NewsReplayRemoteDataSrc{
  Future<void> createReplay(ReplayEntity2 replay);
  Stream<List<ReplayEntity2>> readReplays(ReplayEntity2 replay);
  Future<void> updateReplay(ReplayEntity2 replay);
  Future<void> deleteReplay(ReplayEntity2 replay);
  Future<void> likeReplay(ReplayEntity2 replay);
}