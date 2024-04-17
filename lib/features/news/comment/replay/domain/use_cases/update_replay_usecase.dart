

import 'package:uni_link/features/news/comment/replay/domain/entities/replay_entity.dart';
import 'package:uni_link/features/news/comment/replay/domain/repositories/replay_repository.dart';

class UpdateNewsReplayUseCase {
  final NewsReplayRepository repository;

  UpdateNewsReplayUseCase({required this.repository});

  Future<void> call(ReplayEntity2 replay) {
    return repository.updateReplay(replay);
  }
}