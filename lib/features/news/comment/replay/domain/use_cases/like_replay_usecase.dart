

import 'package:uni_link/features/news/comment/replay/domain/entities/replay_entity.dart';
import 'package:uni_link/features/news/comment/replay/domain/repositories/replay_repository.dart';

class LikeNewsReplayUseCase {
  final NewsReplayRepository repository;

  LikeNewsReplayUseCase({required this.repository});

  Future<void> call(ReplayEntity2 replay) {
    return repository.likeReplay(replay);
  }
}